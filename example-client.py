#!/usr/bin/python
# coding: utf-8
import requests
import sys
import getopt

def print_usage():
  print 'example-client.py -u http://url.to.save/ -t tagone,tagtwo'

def main(argv):
  linkdump_url = 'http://username:password@localhost:9292'
  tags = ""

  try:
     opts, args = getopt.getopt(argv,"hu:t:",["url=","tags="])
  except getopt.GetoptError:
     print_usage()
     sys.exit(2)
  for opt, arg in opts:
     if opt == '-h':
        print_usage()
        sys.exit()
     elif opt in ("-u", "--url"):
        url = arg
     elif opt in ("-t", "--tags"):
        tags = arg

  if not url:
    print('No input URL found.')
    return
  print(url)

  headers = {
    'Content-Type': 'application/json',
  }

  data = '{' +\
           '"url": "' + url + '",' +\
           '"tags": "' + tags + '"' +\
         '}'

  r = requests.post(linkdump_url + '/api/links', headers=headers, data=data)
  print(r.status_code)

if __name__ == '__main__':
  main(sys.argv[1:])
