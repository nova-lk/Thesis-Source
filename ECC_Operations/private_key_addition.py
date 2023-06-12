import tinyec.ec as ec
import tinyec.registry as reg
import random

# select curve
curve = reg.get_curve("secp192r1")
# generator for secp192r1 --> https://neuromancer.sk/std/secg/secp192r1#
G = ec.Point(curve, 0x188da80eb03090f67cbf20eb43a18800f4ff0afd82ff1012, 0x07192b95ffc8da78631011ed6b24cdd573f977a11e794811)

#private key 1 -> 192 bit value for curve secp192r1
key1 = random.getrandbits(192)
#private key 2 -> 192 bit value for curve secp192r1
key2 = random.getrandbits(192)

#Point Addition
key_add = key1 + key2
print(key_add)
