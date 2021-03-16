import sys
import datetime
import glob
import os
import smtplib
import socket
from email.message import EmailMessage


def getlogfile(logdir
              ,logtype):

    # ex get most recent qa-* log from a log dir with logs like
    # import.log
    # export-20210126-165353
    # qa-20210126-165300

    list_of_logs = glob.glob(os.path.join(logdir
                                         ,'{0}*.log'.format(logtype)))

    latest_log = max(list_of_logs, key=os.path.getctime)

    with open(os.path.join(logdir, latest_log), 'r') as file:
        loglines = file.read()

    return loglines

if __name__ == "__main__":

    notification    = sys.argv[1]
    pemails         = sys.argv[2]
    plogtype        = sys.argv[3] # ex 'qa' 'export' '*' (latest)
    logdir          = os.environ['TARGETLOGDIR']
    emailfrom       = os.environ['NOTIFYFROM']
    smtpfrom        = os.environ['SMTPFROM']

    msg = EmailMessage()

    # content is like "importing buildings onto xxx.sde"

    content  = 'Completed {0} '.format(notification)
    msg['Subject'] = content
    content += 'at {0} {1}'.format(datetime.datetime.now(), os.linesep)

    content += getlogfile(logdir
                         ,plogtype)   
    
    msg.set_content(content)
    
    msg['From'] = emailfrom
    msg['To'] = pemails

    s = smtplib.SMTP(smtpfrom)
    s.send_message(msg)
    s.quit()

