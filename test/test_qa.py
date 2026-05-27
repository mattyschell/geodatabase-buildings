import unittest
import os
import sys
import types
import importlib
import subprocess


class QaTestCase(unittest.TestCase):

    @classmethod
    def import_qa_module(cls):

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

    def test_fetchsql_building_is_demolished_requires_live_building(self):

        qa = self.import_qa_module()

        with self.assertRaises(ValueError):
            qa.fetchsql('building_is_demolished', 'building_historic')

    def test_fetchsql_building_is_demolished_targets_historic_view(self):

        qa = self.import_qa_module()

        sql = qa.fetchsql('building_is_demolished', 'building')

        self.assertIn('from building_evw a', sql)
        self.assertIn('from building_historic_evw h', sql)
        self.assertIn("h.last_status_type = 'Demolition'", sql)

    def test_fetchsql_rejects_unknown_checks(self):

        qa = self.import_qa_module()

        with self.assertRaises(ValueError):
            qa.fetchsql('not_a_real_check', 'building')

if __name__ == '__main__':
    unittest.main()