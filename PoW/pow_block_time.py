import string
import random
import hashlib
import time
import json

veriHash= hashlib.sha256()
shaHash = hashlib.sha256()

# Sample transaction data
node_data = {
    'id': 24,
    'timestamp': time.time(),
    'transaction': "MNO1 to MNO2, 100kHz-110kHz, 0245h-0415h",
    'prev_hash': "87751dd7dffdf6a56cca72842f6e663d7396f222bd2758d1f347a63044fa8ce5",
    }

example_challenge = json.dumps(node_data)

hash_difficulty = '0000000' # from single 0 to 7 zeros

def generation(challenge=example_challenge, size=25):
    nonce = random.randint(0,4294967295) #32bit nonce --> all 0 to all 1
    attempt = challenge + str(nonce)
    return attempt, nonce


def testAttempt():
    found = False

    while found == False:
        attempt, nonce = generation()
        solution = hashlib.sha256(attempt.encode()).hexdigest()
        if solution.startswith(hash_difficulty):
            found = True
            return nonce, attempt

def verification(winner_nonce):
    nonce = winner_nonce
    full_str = example_challenge + str(nonce)
    solution = hashlib.sha256(full_str.encode()).hexdigest()
    print("Verification: ", solution.startswith(hash_difficulty))


start_time = time.time()
win_nonce, full_str = testAttempt()
end_time = time.time()
print(f"Time to find correct nonce: {end_time - start_time:.4f}")

start_time2 = time.time()
verification(win_nonce)
end_time2 = time.time()
print(f"Time for verification: {end_time2 - start_time2:.4f}")

