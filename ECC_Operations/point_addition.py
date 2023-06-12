import tinyec.ec as ec
import tinyec.registry as reg
import random
import time

# select curve
curve = reg.get_curve("secp192r1")

# generator for secp192r1 --> https://neuromancer.sk/std/secg/secp192r1#
G = ec.Point(curve, 0x188da80eb03090f67cbf20eb43a18800f4ff0afd82ff1012, 0x07192b95ffc8da78631011ed6b24cdd573f977a11e794811)

#private key 1
key1 = random.getrandbits(192)

#private key 2
key2 = random.getrandbits(192)

#Point 1
p1 = key1*G

#Point 2
p2 = key2*G

start_time = time.time();
#Point Addition
p3 = p1 + p2

end_time = time.time();

print("New point: ", p3)
print(f"Execution time: {end_time - start_time:.2f} seconds")


