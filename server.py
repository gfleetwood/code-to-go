from base64 import b64encode, b64decode
import requests
from json import loads
from os import environ

def code_exec(code):

  code = b64encode(code.encode('ascii')).decode('utf-8')
  url = "https://judge0-ce.p.rapidapi.com/submissions"
  querystring = {"base64_encoded":"true", "fields":"stdout"}
  payload = '{{\n    \"language_id\": 70,\n    \"source_code\": \"{}\",\n    \"stdin\": \"SnVkZ2Uw\"\n}}'.format(code)
  
  headers = {
      'content-type': "application/json",
      'x-rapidapi-host': "judge0-ce.p.rapidapi.com", 
      'x-rapidapi-key': environ["JUDGE_ZERO"]
      }
  
  response = requests.request("POST", url, data = payload, headers = headers, params = querystring)
  execution = requests.request("GET", url + "/" + loads(response.text)["token"], headers = headers)
  result = execution.json()['stdout']
  
  return(result)
