import importlib.util
import pathlib
import sys
import unittest
from unittest import mock


class FetchBuildingArchiveTestCase(unittest.TestCase):

    def test_main_delegates_to_library_and_returns_output(self):
        fc = mock.Mock()
        gdb = mock.Mock()
        spec = importlib.util.spec_from_file_location(
            'fetch_archive_test_subject',
            pathlib.Path(__file__).resolve().parents[1] /
            'fetch_building_archive.py')
        module = importlib.util.module_from_spec(spec)
        with mock.patch.dict(sys.modules, {
                'arcpy': mock.Mock(), 'fc': fc, 'gdb': gdb}):
            spec.loader.exec_module(module)

        for source, extra_excluded in (
                ('BLDG.BUILDING', ('alteration_year',)),
                ('building', ('alteration_year',)),
                ('bldg.building', ('alteration_year',)),
                ('BLDG.BUILDING_HISTORIC', ()),
                ('building_historic', ())):
            with self.subTest(source=source):
                fc.reset_mock()
                output = module.main(source, '20260101', r'C:\Temp')

                fc.Fc.assert_called_once_with(gdb.Gdb.return_value, source)
                fc.Fc.return_value.exportarchive.assert_called_once_with(
                    '20260101', r'C:\Temp', 'America/New_York',
                    exclude_fields=(
                        'last_edited_user', 'created_user', 'addressable',
                        'status', 'condo_flags') + extra_excluded)
                self.assertIs(output, fc.Fc.return_value.exportarchive.return_value)


if __name__ == '__main__':
    unittest.main()
