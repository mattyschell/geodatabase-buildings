import unittest
import os
import sys
import types
import importlib
import subprocess


class QaTestCase(unittest.TestCase):

    @classmethod
    def import_qa_module(cls):

        repo_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

        if repo_root not in sys.path:
            sys.path.insert(0, repo_root)

        sys.modules['gdb'] = types.SimpleNamespace()
        sys.modules['cx_sde'] = types.SimpleNamespace()

        if 'qa' in sys.modules:
            return importlib.reload(sys.modules['qa'])

        return importlib.import_module('qa')

    @classmethod
    def setUpClass(self):

        self.propy = os.environ.get('PROPY')
        self.sdefile = os.environ.get('SDEFILE')
        self.targetlogdir = os.environ.get('TARGETLOGDIR')
        self.testfc = 'BUILDING'

    @classmethod
    def tearDownClass(self):

        pass

    def test_aqa(self):

        if not self.propy:
            self.skipTest('PROPY is not set')

        if not self.sdefile:
            self.skipTest('SDEFILE is not set')

        if not os.path.exists(self.sdefile):
            self.skipTest('SDEFILE does not exist: {0}'.format(self.sdefile))

        if not self.targetlogdir:
            self.skipTest('TARGETLOGDIR is not set')

        if not os.path.isdir(self.targetlogdir):
            self.skipTest('TARGETLOGDIR does not exist: {0}'.format(self.targetlogdir))

        result = subprocess.run([self.propy
                                ,'qa.py'
                                ,self.testfc]
                               ,check=False)

        self.assertEqual(result.returncode
                        ,0
                        ,'qa.py exited with {0}'.format(result.returncode))

    def test_fetchsql_building_not_demolished_requires_historic(self):

        qa = self.import_qa_module()

        with self.assertRaises(ValueError):
            qa.fetchsql('building_not_demolished', 'building')

    def test_fetchsql_building_not_demolished_targets_historic_with_live_join(self):

        qa = self.import_qa_module()

        sql = qa.fetchsql('building_not_demolished', 'building_historic')

        self.assertIn('from building_historic_evw a', sql)
        self.assertIn('from building_evw b', sql)
        self.assertIn("a.last_status_type = 'Demolition'", sql)

    def test_fetchsql_last_status_type_filter(self):

        qa = self.import_qa_module()

        sql = qa.fetchsql('last_status_type', 'building')

        self.assertIn('a.last_status_type not in', sql)
        self.assertIn("'Investigate Demolition'", sql)
        self.assertIn('and trim(a.last_status_type) is not null', sql)

    def test_fetchsql_rejects_unknown_checks(self):

        qa = self.import_qa_module()

        with self.assertRaises(ValueError):
            qa.fetchsql('not_a_real_check', 'building')

if __name__ == '__main__':
    unittest.main()