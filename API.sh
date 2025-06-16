#!/bin/bash

# Twój klucz API z OMDb (załóż darmowe konto na https://www.omdbapi.com/apikey.aspx)
API_KEY="TWOJ_KLUCZ_API"

# Sprawdzenie, czy podano tytuł filmu jako argument
if [ -z "$1" ]; then
    echo "Użycie: $0 \"Tytuł filmu\""
    exit 1
fi

# Łączenie wszystkich argumentów w jeden ciąg (pełny tytuł filmu)
TITLE="$*"

# Pobranie danych z OMDb API
response=$(curl -s "http://www.omdbapi.com/?t=$(echo $TITLE | sed 's/ /+/g')&apikey=$API_KEY")

# Sprawdzenie czy odpowiedź zawiera dane
if [[ $(echo "$response" | jq -r '.Response') != "True" ]]; then
    echo "Nie znaleziono filmu: $TITLE"
    exit 1
fi

# Wyciąganie i wyświetlanie danych
echo "Tytuł:        $(echo "$response" | jq -r '.Title')"
echo "Rok:          $(echo "$response" | jq -r '.Year')"
echo "Gatunek:      $(echo "$response" | jq -r '.Genre')"
echo "Reżyser:      $(echo "$response" | jq -r '.Director')"
echo "Ocena IMDb:   $(echo "$response" | jq -r '.imdbRating')"
echo "Opis:         $(echo "$response" | jq -r '.Plot')"

#!/bin/bash

# Wstaw swój klucz API tutaj
API_KEY="TWOJ_KLUCZ_API"

# Sprawdź, czy podano adres IP
if [ -z "$1" ]; then
    echo "Użycie: $0 <adres_ip>"
    exit 1
fi

IP="$1"

# Pobierz dane z API ipstack
response=$(curl -s "http://api.ipstack.com/$IP?access_key=$API_KEY")

# Sprawdź, czy odpowiedź zawiera dane
if [[ "$response" == *"error"* ]]; then
    echo "Błąd: nie można pobrać informacji dla IP $IP"
    echo "$response" | jq
    exit 1
fi

# Wyodrębnij dane
city=$(echo "$response" | jq -r '.city')
country=$(echo "$response" | jq -r '.country_name')
latitude=$(echo "$response" | jq -r '.latitude')
longitude=$(echo "$response" | jq -r '.longitude')

# Wyświetl dane
echo "Informacje o IP: $IP"
echo "Miasto: $city"
echo "Kraj: $country"
echo "Współrzędne: $latitude, $longitude"

