#!/usr/bin/env python

import sys
import smtplib

def main():
    try:
        validate_args(sys.argv)
        send_text(sys.argv)
    except:
        sys.exit(1)
    sys.exit(0)

def validate_args(args):
    if len(args) != 3:
        print 'Two arguments are required: minerId, message'
        sys.exit(1)

def send_text(args):
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login('SOURCE_EMAIL_HERE', 'YOUR_PASSWORD_HERE')
    message = '\n' + args[1] + ': ' + args[2]
    server.sendmail('EMAIL_SUBJECT_HERE', 'DESTINATION_EMAIL_HERE', message)
    server.quit()

if __name__ == "__main__":
    main()
