import socket

def scan_ports(ip, start_port, end_port):
    print(f"Skanowanie portów na hoście {ip} od {start_port} do {end_port}")

    for port in range(start_port, end_port + 1):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(0.5)

        result = sock.connect_ex((ip, port))
        if result == 0:
            print(f"Port {port} jest otwarty")
        else:
            sock.close()

if __name__ == "__main__":
    target_ip = '192.168.1.39'
    start =  442
    end = 444

    scan_ports(target_ip, start, end)
