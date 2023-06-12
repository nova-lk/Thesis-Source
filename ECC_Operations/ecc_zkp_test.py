import hashlib
import random
import time;
import tinyec.ec as ec # https://pypi.org/project/tinyec/
import tinyec.registry as reg


pk_list = []  # private key list
publicKeyList = []  # public key list
hash_list = []  # hash list
c_list = []  # c value list
s_list = []  # s value list
ver_hash = []  # verifiers' hash list
xP_list = []
privateKeySum = 0

rP = 0

# select curve
curve = reg.get_curve("secp192r1")

# generator for secp192r1 --> https://neuromancer.sk/std/secg/secp192r1#
G = ec.Point(curve, 0x188da80eb03090f67cbf20eb43a18800f4ff0afd82ff1012,
             0x07192b95ffc8da78631011ed6b24cdd573f977a11e794811)

# generate random private keys for 10 nodes
for pk in range(10):
    randInteger = random.getrandbits(192)
    pk_list.append(randInteger)
    privateKeySum += randInteger

# generate public key list
for privateKey in pk_list:
    publicKey = privateKey * G
    publicKeyList.append(publicKey)

# point P
P = ec.Point(curve, 0xd458e7d127ae671b0c330266d246769353a012073e97acf8,
             0x325930500d851f336bddc050cf7fb11b5673a1645086df3b)

# Gerenate r and A --> A = r.G

start_time = time.time()

# Random r such that A = r*G
r = 0xa12a123d60baec0c0dd41b13a542483a8255391af64c6400
A = r*G

# Group required data for the HASH
part1 = str(privateKeySum*P)
part2 = str(r*P)
part3 = str(A)
prover_hash = part1 + part2 + part3
prover_hash = hashlib.sha1(prover_hash.encode()).hexdigest()
c = int(prover_hash, 16)

# s value
s = r + c*privateKeySum


proverData = {
    'privateKey': privateKeySum,
    'randomNumber': r,
    'hash': c,
    's': s
}

proverSend = {
    's': s,
    'aP': privateKeySum * P,
    'rP': r * P,
    'A': A
}


# --------------------VERIFIERS------------------------
# knows EC, G, P, B,      s, xP, rP, A

verifierGet = {
    's': s,
    'aP': privateKeySum * P,
    'rP': r * P,
    'A': A
}

finalPublicKey = publicKeyList[0]
for p in range(1, len(publicKeyList)):
    finalPublicKey += publicKeyList[p]

sG = verifierGet['s']*G == verifierGet['A'] + proverData['hash']*finalPublicKey
sP = verifierGet['s']*P == verifierGet['rP'] + proverData['hash']*proverData['privateKey']*P
stop_time = time.time();

print("sG = A + cB => ", sG)
print("sP = rP + cxP => ", sP)

print(f"Execution time: {stop_time - start_time:.2f} seconds")
