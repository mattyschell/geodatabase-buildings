import argparse
import logging
import os
from pathlib import Path
import time

import arcpy
import fc
import gdb


ARCHIVE_EXCLUDED_FIELDS = (
    'last_edited_user',
    'created_user',
    'addressable',
    'status',
    'condo_flags',
)


def main(sourcefcname, snapshotdate, targetdir):
    sourcefc = fc.Fc(gdb.Gdb(), sourcefcname)
    excluded_fields = ARCHIVE_EXCLUDED_FIELDS
    if sourcefcname.rsplit('.', 1)[-1].upper() == 'BUILDING':
        excluded_fields += ('alteration_year',)
    return sourcefc.exportarchive(
        snapshotdate, targetdir, 'America/New_York',
        exclude_fields=excluded_fields)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Export a feature class snapshot at midnight UTC.')
    parser.add_argument('featureclass', help='For example, BLDG.BUILDING_HISTORIC')
    parser.add_argument('snapshotdate', help='Snapshot date in YYYYMMDD format')
    parser.add_argument('outputdir', help='Existing output directory')
    args = parser.parse_args()

    logdir = Path(os.environ['TARGETLOGDIR'])
    logdir.mkdir(parents=True, exist_ok=True)
    targetlog = logdir / 'building_archive-{}.log'.format(
        time.strftime('%Y%m%d-%H%M%S'))
    logging.basicConfig(filename=str(targetlog), level=logging.INFO)

    try:
        output = main(args.featureclass, args.snapshotdate, args.outputdir)
    except (arcpy.ExecuteError, OSError, ValueError, KeyError):
        logging.exception('Failed to export archive for %s', args.featureclass)
        raise

    logging.info('Successfully exported %s', output)
    print(output)
