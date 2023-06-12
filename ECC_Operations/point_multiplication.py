import tinyec.ec as ec
import tinyec.registry as reg
import random
import time

# select curve
curve = reg.get_curve("secp192r1")

# generator for secp192r1 --> https://neuromancer.sk/std/secg/secp192r1#
G = ec.Point(curve, 0x188da80eb03090f67cbf20eb43a18800f4ff0afd82ff1012, 0x07192b95ffc8da78631011ed6b24cdd573f977a11e794811)

#generate random 192-bit private key
priv_key = random.getrandbits(192)

start_time = time.time();
#generate public key
pub_key = priv_key * G

end_time = time.time();

print("New point: ", pub_key)
print(f"Execution time: {end_time - start_time:.2f} seconds")

