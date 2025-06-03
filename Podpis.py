from Crypto.Cipher import PKCS1_OAEP
from Crypto.PublicKey import RSA
import hashlib

def calculateHash(message):
    m = hashlib.sha256()
    m.update(message)
    return m.digest()

class SignedFile:
    message: bytes = None
    digitalsignature: bytes = None

    def __init__(self, filepath: str):
        with open(filepath, "rb") as file:
            self.message = file.read()
        print(f"Zawartość pliku: {self.message.decode(errors='replace')}")

    def hash_and_sign(self, key):
        hash = calculateHash(self.message)
        print(f"Hash: {hash.hex()}")

        cipher = PKCS1_OAEP.new(key=key)
        self.digitalsignature = cipher.encrypt(hash)
        print(f"Podpis cyfrowy: {self.digitalsignature.hex()}")

if __name__ == "__main__":
    filepath = "szyfrowanie.txt"
    file = SignedFile(filepath=filepath)

    private_key = RSA.generate(1024)
    public_key = private_key.publickey()
    print("Klucze RSA wygenerowane.")

    file.hash_and_sign(public_key)
