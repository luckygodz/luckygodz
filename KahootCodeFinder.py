import requests
import random
import threading

print("Start")

session = requests.Session()
used_codes = set()
valid_codes = []
lock = threading.Lock()

def generate_code():
    return str(random.randint(100000, 999999))

def check_code(session, code):
    url = f"https://kahoot.it/reserve/session/{code}"
    response = session.get(url)
    return response.text.strip() != "Not found"

def worker():
    while True:
        code = generate_code()
        with lock:
            if code not in used_codes:
                used_codes.add(code)
            else:
                continue
        if check_code(session, code):
            with lock:
                valid_codes.append(code)
                print(f"Valid Code Found: {code}")

num_threads = 10
threads = []

for _ in range(num_threads):
    thread = threading.Thread(target=worker)
    thread.daemon = True
    thread.start()
    threads.append(thread)

try:
    while True:
        pass
except KeyboardInterrupt:
    print("\nStopping the finder...")
