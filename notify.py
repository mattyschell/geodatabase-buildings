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
    
    if len(sys.argv) == 4:
        pchecklogfor = 'nothing'
    else:
        # pass in ERROR for example
        # to only notify if ERROR appears in the log
        pchecklogfor = sys.argv[4]

    logdir          = os.environ['TARGETLOGDIR']
    emailfrom       = os.environ['NOTIFYFROM']
    smtpfrom        = os.environ['SMTPFROM']

    msg = EmailMessage()

    # notification is like "importing buildings onto dev.sde"

    content  = 'Completed {0} '.format(notification)
    msg['Subject'] = content
    content += 'at {0} {1}'.format(datetime.datetime.now()
                                  ,os.linesep)

    content += '\n\n' + getlogfile(logdir
                                  ,plogtype)   
    
    msg.set_content(content)    
    msg['From'] = emailfrom

    # this is headers only 
    # if a string is passed to sendmail it is treated as a list with one element!
    msg['To'] = pemails

    if  (pchecklogfor != 'nothing' and pchecklogfor in content) \
    or   pchecklogfor == 'nothing':
        
        smtp = smtplib.SMTP(smtpfrom)

        smtp.sendmail(msg['From']
                     ,msg['To'].split(",")
                     ,msg.as_string())

        smtp.quit()
