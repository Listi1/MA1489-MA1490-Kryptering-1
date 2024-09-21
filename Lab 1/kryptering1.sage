#
# kryptering1.sage
# Robert Nyqvist, 2015-2021
#

print("***  kryptering1.sage: Funktioner för kursen Kryptering 1 (SageMath)  ***")

Asve = 'abcdefghijklmnopqrstuvxyzåäö'

def sve(t) :
    if isinstance(t, str) :
        kodning = {Asve[i]:i for i in range(len(Asve))}
        m = list(map(lambda x : kodning[x], t))
    else :
        t = list(map(lambda x : Asve[x], t))
        m = ''.join(t)
    return m

def affint_krypto(t, a, b) :
    m = sve(t)
    c = [(a * x + b) % 28 for x in  m]
    return sve(c)

def Caesarchiffer(t, s = 3) :
    return affint_krypto(t, 1, s)

def substitutionskrypto(t, n, A = Asve) :
    k = {A[i]:n[i] for i in range(len(A))}
    c = list(map(lambda x : k[x] if x in k.keys() else x, t))
    return ''.join(c)

def Vigenerekrypto(t, k) :
    c = sve(t)
    k = sve(k)
    n = len(k)
    for i in range(len(c)) :
        j = i % n
        c[i] = (c[i] + k[j]) % 28
    return sve(c)

def transpositionskrypto(t, n, metod = 'kryptera') :
    if metod in ['kryptera', 'dekryptera'] :
        m = len(t)
        k = len(n)
        if metod == 'kryptera' :
            c = ''
        else :
            c = len(t) * [' ']
            r = 0
        for i  in range(k) :
            for j in range(n[i], m, k) :
                if metod == 'kryptera' :
                    c += t[j]
                else :
                    c[j] = t[r]
                    r += 1
        if metod == 'dekryptera' :
            c = ''.join(c)
        return c
    else :
        return 'Okänd metod!'

def Playfair(t, n, x = 'x', metod = 'kryptera') :
    if metod in ['kryptera', 'dekryptera'] :
        if metod == 'kryptera' :
            M = 1
        else :
            M = -1
        s = t.replace('j', 'i')
        t = ''
        while s != '' :
            if len(s) >= 2 :
                if s[0] != s[1] :
                    t += s[:2]
                    s = s[2:]
                else :
                    t += s[0] + x
                    s = s[1:]
            else :
                t += s + x
                s = ''
        c = ''
        for i in range(0, len(t), 2) :
            a = ZZ(n.index(t[i]))
            q1, r1 = a.quo_rem(5)
            b = ZZ(n.index(t[i+1]))
            q2, r2 = b.quo_rem(5)
            if q1 == q2 :  # samma rad
                x = 5 * q1 + ((r1 + M) % 5)
                y = 5 * q2 + ((r2 + M) % 5)
            elif r1 == r2 :  # samma kolumn
                x = 5 * ((q1 + M) % 5) + r1
                y = 5 * ((q2 + M) % 5) + r2
            else :
                x = 5 * q1 + r2
                y = 5 * q2 + r1
            c += n[x] + n[y]
        return c
    else :
        return 'Okänd metod!'

def ADFGVX(t, n, p, metod = 'kryptera') :
    A = 'ADFGVX'
    c = ''
    if metod == 'kryptera' :
        for i in range(len(t)) :
            j = ZZ(n.index(t[i]))
            q, r = j.quo_rem(6)
            c += A[q] + A[r]
        c = transpositionskrypto(c, p)
        return c
    elif metod == 'dekryptera' :
        t = transpositionskrypto(t, p, metod = 'dekryptera')
        for i in range(0, len(t), 2) :
            q = A.index(t[i])
            r = A.index(t[i+1])
            j = 6 * q + r
            c += n[j]
        return c
    else :
        return 'Okänd metod!'

def Enigma(t, k, r, s) :
    A = '_ABCDEFGHIJKLMNOPQRSTUVWXYZ'  # alfabet för Enigma
    rotor = {'I':'EKMFLGDQVZNTOWYHXUSPAIBRCJ',
             'II':'AJDKSIRUXBLHWTMCQGZNPYFVOE',
             'III':'BDFHJLCPRTXVZNYEIWGAKMUSQO',
             'IV':'ESOVPZJAYQUIRHXLNFTGKDCMWB',
             'V':'VZBRGITYUPSDNHLXAWMJQOFECK'}
    hack = {'I':'Q', 'II':'E', 'III':'V', 'IV':'J', 'V':'Z'}
    # rotor 1
    rho1 = Permutation([A.index(x) for x in rotor[r[0]]])
    rho1inv = rho1.inverse()
    h1 = A.index(hack[r[0]])
    k1 = A.index(s[0])
    # rotor 2
    rho2 = Permutation([A.index(x) for x in rotor[r[1]]])
    rho2inv = rho2.inverse()
    h2 = A.index(hack[r[1]])
    k2 = A.index(s[1])
    # rotor 3
    rho3 = Permutation([A.index(x) for x in rotor[r[2]]])
    rho3inv = rho3.inverse()
    # h3 = A.index(hack[r[2]])
    k3 = A.index(s[2])
    # reflektor
    tau = Permutation([A.index(x) for x in 'YRUHQSLDPXNGOKMIEBFZCWVJAT'])
    # permutation för kopplingstavla
    p = ''.join(map(str, [(A.index(x), A.index(y)) for (x, y) in k]))
    if p.find('26') < 0 :
        p += '(26)'
    beta = Permutation(p)
    # rotationspermutation
    def sigma(a, n) :
        b = (a + n) % 26
        if b == 0 :
            b = 26
        return b
    # kryptering/dekryptering
    c = ''
    for m, x in enumerate(t) :
        l1 = m
        l2 = floor((h1 + k1 + l1)/26)
        l3 = floor((h2 + k2 + l2)/26)
        # koda klartext som heltal
        y = A.index(x)
        # kopplingstavla
        y = beta(y)
        # rotor 1
        y = sigma(rho1(sigma(y, k1 + l1)), -k1 - l1)
        # rotor 2
        y = sigma(rho2(sigma(y, k2 + l2)), -k2 - l2)
        # rotor 3
        y = sigma(rho3(sigma(y, k3 + l3)), -k3 - l3)
        # reflektor
        y = tau(y)
        # rotor 3
        y = sigma(rho3inv(sigma(y, k3 + l3)), -k3 - l3)
        # rotor 2
        y = sigma(rho2inv(sigma(y, k2 + l2)), -k2 - l2)
        # rotor 1
        y = sigma(rho1inv(sigma(y, k1 + l1)), -k1 - l1)
        # kopplingstavla
        y = beta(y)
        # koda heltal till kryptogram
        c += A[y]
    return c

def Hillkrypto(t, M, x = 'x', typ = 'V') :
    m = 28
    # antag att matrisen M är kvadratisk
    # konvertera klartexten/kryptogrammet til en matris
    j = M.nrows()  # blocklängd, d.v.s. antal kolonner
    t = t + (-len(t) % j) * x  # lägg till utfyllnadstecken
    i = len(t) // j  # antal rader
    P = matrix(Zmod(m), i, j, sve(t))
    if typ == 'V' :
        C = P * M
    elif typ == 'H' :
        C = (M * P.transpose()).transpose()
    else :
        return u'Felaktig typ!'
    # konvertera från matris till text
    c = flatten([list(r) for r in C])
    return sve(c)

def monogramanalys(t, typ = 'diagram') :
    A = Asve
    f = [t.count(x) for x in A]
    if typ == 'diagram' :
        fd = Graphics()
        o = 0.05 * max(f)
        for i in range(len(A)) :
            fd += line([(i,0), (i,f[i])], thickness=10)
            fd += text(A[i], (i,-o), fontsize='large', vertical_alignment='top')
        fd.axes(False)
        fd.show()
    elif typ == 'tabell' :
        for i in range(len(A)) :
            print(A[i], ' : ', f[i])
    elif typ == 'lista' :
        return {A[i]:f[i] for i in range(len(A))}
    else :
        print('Okänd typ')

def bigramanalys(t, antal_bigram = 25) :
    l = [t[i:i+2] for i in range(len(t)-1)]
    u = list(set(l))
    f = {x:l.count(x) for x in u}
    b = sorted(f.items(), key = lambda x : x[1])
    n = min(antal_bigram, len(b))
    for i in range(len(b)-1, len(b)-n-1, -1) :
        print(b[i][0], ' : ', b[i][1])

def trigramanalys(t, antal_trigram = 25) :
    l = [t[i:i+3] for i in range(len(t)-2)]
    u = list(set(l))
    f = {x:l.count(x) for x in u}
    b = sorted(f.items(), key = lambda x : x[1])
    n = min(antal_trigram, len(b))
    for i in range(len(b)-1, len(b)-n-1, -1) :
        print(b[i][0], ' : ', b[i][1])

def BabbageKasiski(t, d) :
    p = []
    k = t.find(d, 0)
    while k != -1 :
        p.append(k)
        k = t.find(d, k + 1)
    return p

def Friedman(t, s) :
    t1 = t + s * u'-'
    t2 = s * u'-' + t
    n = sum([x == y for x, y in zip(t1, t2)])
    return n

def splittra_text(t, n) :
    s = []
    for k in range(n) :
        d = [t[i] for i in range(k, len(t), n)]
        s.append(''.join(d))
    return s

# DES

def text_till_block64(text) :
    n = -len(text) % 8
    m = text + n * ' '  # utfyllnadstecken: mellanslag
    b = flatten([ZZ(ord(t)).digits(base = 2, padto = 8) for t in m])
    block = [b[i:i+64] for i in range(0, len(b), 64)]
    return block

def block64_till_text(block, typ = 'text') :
    def till_dec(b) :
        return [ZZ(b[k:k+8], base = 2) for k in range(0, len(b), 8)]
    if typ == 'text' :
        d = flatten(list(map(till_dec, block)))
        t = list(map(chr, d))
        return ''.join(t)
    elif typ == 'hex' :
        d = list(map(till_dec, block))
        h = [[''.join(a.digits(base = 16, digits = '0123456789ABCDEF', padto = 2)[::-1]) for a in b] for b in d]
        return [''.join(b) for b in h]
    elif typ == 'bin' :
        return [''.join(list(map(str, b))) for b in block]
    else :
        return 'Okänd typ!'

IP_permutation = [58, 50, 42, 34, 26, 18, 10, 2, 60, 52, 44, 36, 28, 20, 12, 4,
                  62, 54, 46, 38, 30, 22, 14, 6, 64, 56, 48, 40, 32, 24, 16, 8,
                  57, 49, 41, 33, 25, 17,  9, 1, 59, 51, 43, 35, 27, 19, 11, 3,
                  61, 53, 45, 37, 29, 21, 13, 5, 63, 55, 47, 39, 31, 23, 15, 7]

def IP(m) :
    m0 = list(map(lambda i : m[i-1], IP_permutation))
    return m0

def IPinv(m) :
    c = 64 * [0]
    for i in range(64) :
        c[IP_permutation[i]-1] = m[i]
    return c

def Sbox_DES(B, i) :
    S = [# S-box 1
        [[14,  4, 13, 1,  2, 15, 11,  8,  3, 10,  6, 12,  5,  9, 0,  7],
         [ 0, 15,  7, 4, 14,  2, 13,  1, 10,  6, 12, 11,  9,  5, 3,  8],
         [ 4,  1, 14, 8, 13,  6,  2, 11, 15, 12,  9,  7,  3, 10, 5,  0],
         [15, 12,  8, 2,  4,  9,  1,  7,  5, 11,  3, 14, 10,  0, 6, 13]],
        # S-box 2
        [[15,  1,  8, 14,  6, 11,  3,  4,  9, 7,  2, 13, 12, 0,  5, 10],
         [ 3, 13,  4,  7, 15,  2,  8, 14, 12, 0,  1, 10,  6, 9, 11,  5],
         [ 0, 14,  7, 11, 10,  4, 13,  1,  5, 8, 12,  6,  9, 3,  2, 15],
         [13,  8, 10,  1,  3, 15,  4,  2, 11, 6,  7, 12,  0, 5, 14,  9]],
        # S-box 3
        [[10,  0,  9, 14, 6,  3, 15,  5,  1, 13, 12,  7, 11,  4,  2,  8],
         [13,  7,  0,  9, 3,  4,  6, 10,  2,  8,  5, 14, 12, 11, 15,  1],
         [13,  6,  4,  9, 8, 15,  3,  0, 11,  1,  2, 12,  5, 10, 14,  7],
         [ 1, 10, 13,  0, 6,  9,  8,  7,  4, 15, 14,  3, 11,  5,  2, 12]],
        # S-box 4
        [[ 7, 13, 14, 3,  0,  6,  9, 10,  1, 2, 8,  5, 11, 12,  4, 15],
         [13,  8, 11, 5,  6, 15,  0,  3,  4, 7, 2, 12,  1, 10, 14,  9],
         [10,  6,  9, 0, 12, 11,  7, 13, 15, 1, 3, 14,  5,  2,  8,  4],
         [ 3, 15,  0, 6, 10,  1, 13,  8,  9, 4, 5, 11, 12,  7,  2, 14]],
        # S-box 5
        [[ 2, 12,  4,  1,  7, 10, 11,  6,  8,  5,  3, 15, 13, 0, 14,  9],
         [14, 11,  2, 12,  4,  7, 13,  1,  5,  0, 15, 10,  3, 9,  8,  6],
         [ 4,  2,  1, 11, 10, 13,  7,  8, 15,  9, 12,  5,  6, 3,  0, 14],
         [11,  8, 12,  7,  1, 14,  2, 13,  6, 15,  0,  9, 10, 4,  5,  3]],
        # S-box 6
        [[12,  1, 10, 15, 9,  2,  6,  8,  0, 13,  3,  4, 14,  7,  5, 11],
         [10, 15,  4,  2, 7, 12,  9,  5,  6,  1, 13, 14,  0, 11,  3,  8],
         [ 9, 14, 15,  5, 2,  8, 12,  3,  7,  0,  4, 10,  1, 13, 11,  6],
         [ 4,  3,  2, 12, 9,  5, 15, 10, 11, 14,  1,  7,  6,  0,  8, 13]],
        # S-box 7
        [[ 4, 11,  2, 14, 15, 0,  8, 13,  3, 12, 9,  7,  5, 10, 6,  1],
         [13,  0, 11,  7,  4, 9,  1, 10, 14,  3, 5, 12,  2, 15, 8,  6],
         [ 1,  4, 11, 13, 12, 3,  7, 14, 10, 15, 6,  8,  0,  5, 9,  2],
         [ 6, 11, 13,  8,  1, 4, 10,  7,  9,  5, 0, 15, 14,  2, 3, 12]],
        # S-box 8
        [[13,  2,  8, 4,  6, 15, 11,  1, 10,  9,  3, 14,  5,  0, 12,  7],
         [ 1, 15, 13, 8, 10,  3,  7,  4, 12,  5,  6, 11,  0, 14,  9,  2],
         [ 7, 11,  4, 1,  9, 12, 14,  2,  0,  6, 10, 13, 15,  3,  5,  8],
         [ 2,  1, 14, 7,  4, 10,  8, 13, 15, 12,  9,  0,  3,  5,  6, 11]]
        ]
    r = ZZ([B[j] for j in [0, -1]], base = 2)  # rad
    k = ZZ(B[1:-1], base = 2)                  # kolumn
    c = S[i][r][k]
    C = c.digits(base = 2, padto = 4)
    return C

def f_DES(R, K) :
    def E(R) :
        p = [32,  1,  2,  3,  4,  5,  4,  5,  6,  7,  8,  9,
             8,  9, 10, 11, 12, 13, 12, 13, 14, 15, 16, 17,
             16, 17, 18, 19, 20, 21, 20, 21, 22, 23, 24, 25,
             24, 25, 26, 27, 28, 29, 28, 29, 30, 31, 32,  1];
        y = 48 * [0]
        for i in range(48) :
            y[i] = R[p[i]-1]
        return y
    p = [16, 7, 20, 21, 29, 12, 28, 17,  1, 15, 23, 26,  5, 18, 31, 10,
         2, 8, 24, 14, 32, 27,  3,  9, 19, 13, 30,  6, 22, 11,  4, 25];
    B = [(x + y) % 2 for x, y in  list(zip(E(R), K))]
    Bi = [B[i:i+6] for i in range(0, 48, 6)]
    Ci = [Sbox_DES(Bj, j) for j, Bj in enumerate(Bi)]
    C = flatten(Ci)
    y = [C[k-1] for k in p]
    return y

def DES(m, K) :
    # Initrial Permutation
    m0 = IP(m)
    # dela upp i vänster- oc högerblock
    Li = m0[:32]
    Ri = m0[32:]
    # de sexton rundorna av Feistelsystemet
    for i in range(16) :
        S = list(map(lambda x, y : (x + y) % 2, Li, f_DES(Ri, K[i])))  # L + f(R, K)
        Li = Ri
        Ri = S
    # konkatenering
    m = Ri + Li
    # Inverse Initrial Permutation
    c = IPinv(m)
    return c

def rundnycklar_DES(K) :
    def LS(L, k) :
        return L[k:] + L[:k]
    p1 = [57, 49, 41, 33, 25, 17,  9,  1, 58, 50, 42, 34, 26, 18,
          10,  2, 59, 51, 43, 35, 27, 19, 11,  3, 60, 52, 44, 36,
          63, 55, 47, 39, 31, 23, 15,  7, 62, 54, 46, 38, 30, 22,
          14,  6, 61, 53, 45, 37, 29, 21, 13,  5, 28, 20, 12,  4]
    p2 = [14, 17, 11, 24,  1,  5,  3, 28, 15,  6, 21, 10,
          23, 19, 12,  4, 26,  8, 16,  7, 27, 20, 13,  2,
          41, 52, 31, 37, 47, 55, 30, 40, 51, 45, 33, 48,
          44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32]
    s = [1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1]
    K0 = [K[i-1] for i in p1]
    Ci = K0[:28]  # C_0
    Di = K0[28:]  # D_0
    Ki = []
    for i in range(16) :
        Ci = LS(Ci, s[i])
        Di = LS(Di, s[i])
        CD = Ci + Di
        k = list(map(lambda j : CD[j-1], p2))
        Ki += [k]
    return Ki

def text_till_DESnyckel(t) :
    b = list(map(lambda x : ZZ(ord(x)).digits(base = 2, padto = 8), t))
    return flatten(b)

def DES_ECB(block, K, metod = 'kryptering') :
    Ki = rundnycklar_DES(K)
    if metod == 'dekryptering' :
        Ki = Ki[::-1]
    c = list(map(lambda m : DES(m, Ki), block))
    return c
