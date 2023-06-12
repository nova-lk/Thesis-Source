import hashlib
import json
import time

# Sample transaction data
hashdata = {
    'id': 24,
    'timestamp': time.time(),
    'transaction': "MNO1 to MNO2, 100kHz-110kHz, 0245h-0415h",
    'prev_hash': "87751dd7dffdf6a56cca72842f6e663d7396f222bd2758d1f347a63044fa8ce5",
    }

hashdata_str = json.dumps(hashdata)

shaHash = hashlib.sha256()

start_time = time.time()
shaHash.update(hashdata_str.encode())
end_time = time.time()

print("Output: ", shaHash.hexdigest())
print(f"Execution time: {end_time - start_time:.4f} seconds")
