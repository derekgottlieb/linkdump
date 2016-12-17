# coding: utf-8
import requests
import appex
import console
import dialogs

def main():
  linkdump_url = 'http://username:password@localhost:9292'
  if not appex.is_running_extension():
    print('This script is intended to be run from the sharing extension.')
    return
  url = appex.get_url()
  
  tags = dialogs.input_alert('Tags:', '')
  
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
  main()
