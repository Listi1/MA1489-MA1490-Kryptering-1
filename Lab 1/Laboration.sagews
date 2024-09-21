︠d5eab464-0fc0-47a6-b771-189242addc7d︠
%md
# Laboration
Kryptering 1, hösten 2023
︡6d053489-a538-46e8-a6ee-24b00ec8d441︡{"done":true,"md":"# Laboration\nKryptering 1, hösten 2023"}
︠a7043f5a-b763-459f-bb34-9cc0cb853ce0︠
%md
**Namn:** Viktor Listi

︡a6390882-4964-4dbf-b798-ae98dd0590d0︡{"done":true,"md":"**Namn:** Viktor Listi"}
︠186d5089-e490-46e9-8182-29f8161f2842︠

# Laddar användbar fil genom att ställa markören i sällen och tryck Shift+Enter.
load('kryptering1.sage')
︡93560bf3-6092-4a76-8f5e-c7c07f9de5a7︡{"stdout":"***  kryptering1.sage: Funktioner för kursen Kryptering 1 (SageMath)  ***\n"}︡{"done":true}
︠d6e50983-f988-4a51-bd22-bbf16805e39di︠
%md
## Uppgift 1
︡e2e2ac1b-d43f-465d-9826-6840abb98314︡{"done":true,"md":"## Uppgift 1"}
︠dc3f98cc-bb29-44dc-95bf-f17f43f1c0f6︠
klartext = 'imponerande'
# Förskjutning med k = 17
a = Caesarchiffer(klartext, 17)
print('Förskjutning({}) = {}\n'.format(klartext, a.upper()))

#Monoalfabetiskt substitutionskrypto
bKey = 'dqkåaäuröshjiebcpxvfogylmztn'
b = substitutionskrypto(klartext, bKey)
print('Monoalfa subkrypto({}) = {}'.format(klartext, b.upper()))

#Affint med (a,b) = (13,9)
c = affint_krypto(klartext, 13, 9)
print('\nAffint({}) = {}'.format(klartext, c.upper()))

#Vignere
dKey = 'gömd'
d = Vigenerekrypto(klartext, dKey)
print('\nVignere({}) = {}'.format(klartext, d.upper()))

#Transposition
eKey = [2,0,3,1]
e = transpositionskrypto(klartext, eKey)
print('\nTransposition({}) = {}'.format(klartext, e.upper()))

#PlayFair
fKey = 'drlxayszhkepbciqufgmvontw'
f = Playfair(klartext, fKey)
print('\nPlayFair({}) = {}'.format(klartext, f.upper()))

#ADFGVX
gKey1 = [1,4,3,0,2]
gKey2 = 'g6u7aq8rdshjix1f2plw5mt0eb4v9ocykzn3'
g = ADFGVX(klartext, gKey2, gKey1)
print('\nADFGVX({}) = {}'.format(klartext, g))

#Enigma
hKey1 = [('A', 'L'), ('D', 'Q'), ('K', 'N'), ('M', 'S'), ('U', 'X')]
hKey2 = ['II', 'IV', 'I']
hKey3 = 'SYD'
h = Enigma(klartext.upper(), hKey1, hKey2, hKey3)
print('\nEnigma({}) = {}'.format(klartext.upper(), h))

#Hillkrypto
iKey = matrix(Zmod(28), [[5,2,18],[19,1,9],[17,16,13]])
i = Hillkrypto(klartext, iKey, typ = 'H')
print('\nHill({}) = {}'.format(klartext, i.upper()))

#DES
jMessageBinary = text_till_block64(klartext)
jKey = [1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0]
j = DES_ECB(jMessageBinary, jKey)
print('\nDES({}):'.format(klartext))
for block in block64_till_text(j, typ = 'hex') :
    print(block)

#RSA
kKeyE =  1330643366620853071
kKeyN = 3134934063919959150141797353966441
kMessage = sve(klartext)
kMessageModify1 = [num + 1 for num in kMessage]
kMessageModify2= [f'{num:02}' for num in kMessageModify1]
kMessageModify3 = int(''.join(map(str, kMessageModify2)))
k = power_mod(kMessageModify3, kKeyE, kKeyN)
print('\nRSA({}) = {}'.format(klartext, k))

︡50c5de3c-6786-47f9-a287-834d92eccc34︡{"stdout":"Förskjutning(imponerande) = ÅBEDCVGRCUV\n\n"}︡{"stdout":"Monoalfa subkrypto(imponerande) = ÖICBEAXDEÅA\n"}︡{"stdout":"\nAffint(imponerande) = BÅIYKFGJKUF\n"}︡{"stdout":"\nVignere(imponerande) = OLÖRTDBDTCQ\n"}︡{"stdout":"\nTransposition(imponerande) = PREINNOAMED\n"}︡{"stdout":"\nPlayFair(imponerande) = MWURVBLDVLCD\n"}︡{"stdout":"\nADFGVX(imponerande) = AVAXAFVAFGXDDFXVVVGXDV\n"}︡{"stdout":"\nEnigma(IMPONERANDE) = OEKABJKNYAU\n"}︡{"stdout":"\nHill(imponerande) = ÄTTAHXLUKÖHJ\n"}︡{"stdout":"\nDES(imponerande):\n"}︡{"stdout":"572668CA12863B59\nFB0069FC5C04C76F\n"}︡{"stdout":"\nRSA(imponerande) = 492236175884835670950267908035895\n"}︡{"done":true}
︠8abebec0-8c10-421f-9305-f8734cc53c54︠
Kryptogram1 = 'LIGSLAAÄTLMMTNUOIRLREDGM' #Transposition
Kryptogram2 = 'LDEOBMRNJKMMLXYBRJQFPHQZPYIRD' #Enigma
Kryptogram3 = '32107833669138743416991214827014308'  #RSA
Kryptogram4 = 'RBBJDQDEÅBBJDQDEÅGAIHDEIDEJÖFDCZ' #monoalfabetiskt sub
Kryptogram5 = 'JÖBSTFKÄJJSAXLCEÖLUHÖACÄNMLÅMCAOIBTT' #Hill
Kryptogram6 = 'FMJÖJTIBYKFGÖKLHÖFGQFÅMBDJÅFUUFMJKUFK' #Affin
Kryptogram7 = '1DCDB9E4E6EA1049 83B2AE7D8E20B92B 63C8B4251AFAC981 A6F5AED397A81135' #DES
Kryptogram8 = 'IPGCÅCYVCPGÖRHIRU'  #förskjutning
Kryptogram9 = 'VDAFVFDDXVXVGXGAVDFDGAVX' #ADFGVX
Kryptogram10 = 'RTBLMÖPLVKÄPGSQULHGDYEBHJ' #Vignere
Kryptogram11 = 'RVTWPUBAXNYCCPLWHR' #playfair

#förskjutning Kryptogram
förskjutningsKryptogram = sve(Kryptogram8.lower())
förskjutningText = ""
for i in range(len(förskjutningsKryptogram)):
    förskjutningsKryptogram[i] = förskjutningsKryptogram[i] - 17
    förskjutningsKryptogram[i] = Mod(förskjutningsKryptogram[i],28)
    förskjutningText += Asve[förskjutningsKryptogram[i]]
print("förskjutning -",förskjutningText)

#Playfair
playfairKey = 'drlxayszhkepbciqufgmvontw'
playfairMessage = Playfair(Kryptogram11.lower(), playfairKey, metod = 'dekryptera')
print("PlayFair -", playfairMessage)

#Transposition
transKey = [2,0,3,1]
transMessage = transpositionskrypto(Kryptogram1, transKey, metod = 'dekryptera')
print("Transposition -",transMessage)

#affin
a = Mod(13,28)
b = Mod(9,28)
affinMessage = affint_krypto(Kryptogram6.lower(), a^(-1), -a^(-1)*b)
print("Affint -",affinMessage)

#monoalfabetiskt
monoKey = 'dqkåaäuröshjiebcpxvfogylmztn'
monoMessage = substitutionskrypto(Kryptogram4.lower(), Asve ,monoKey)
print("Monoalfabetiskt -",monoMessage)

#Vignere
vignereKey = 'gömd'
vignereKeyFinal = sve([-x % 28 for x in sve(vignereKey)])
vignereMessage = Vigenerekrypto(Kryptogram10.lower(), vignereKeyFinal)
print("Vignere -",vignereMessage)

#Hill
hillKey = matrix(Zmod(28), [[5,2,18],[19,1,9],[17,16,13]])
hillKeyInverse = hillKey.inverse()
hillMessage = Hillkrypto(Kryptogram5.lower(), hillKeyInverse, typ = 'H')
print("Hill -", hillMessage)

#Engima
enigmaKey1 = [('A', 'L'), ('D', 'Q'), ('K', 'N'), ('M', 'S'), ('U', 'X')]
enigmaKey2 = ['II', 'IV', 'I']
enigmaKey3 = 'SYD'
enigmaMessage = Enigma(Kryptogram2, enigmaKey1, enigmaKey2, enigmaKey3)
print("Enigma -",enigmaMessage)

#ADFGVX
adfgvxKey1 = [1,4,3,0,2]
adfgvxKey2 = 'g6u7aq8rdshjix1f2plw5mt0eb4v9ocykzn3'
adfgvxMessage = ADFGVX(Kryptogram9, adfgvxKey2, adfgvxKey1, metod = 'dekryptera')

print("ADFGVX -",adfgvxMessage)

#DES
krypto7 = ['1DCDB9E4E6EA1049', '83B2AE7D8E20B92B', '63C8B4251AFAC981', 'A6F5AED397A81135']
tempList = []
for b in krypto7:
    var1 = [b[i:i+2] for i in range(0,16,2)]
    
    var2 = [ZZ('0x' + h) for h in var1]
    var3 = [bin(d) for d in var2]
    var3 = [b[2:] for b in var3]
    var3 = [b.zfill(8)[::-1] for b in var3]
    var3 = ''.join(var3)
    var3 = [ZZ(b) for b in var3]
    tempList.append(var3)

mainKey = 8*(4*[1]+4*[0])
message = DES_ECB(tempList,mainKey, metod='dekryptering')
print("DES -", block64_till_text(message))


#RSA

x, y, t_0 = var('x y t_0')
n = 36134934063919959150141797353966441
e = 1330643366620853071
ep = euler_phi(n)

temp = solve_diophantine(e*x - ep*y == 1)
temp2 = solve([t_0 >= 0, e*temp[0] - ep*temp[1] == 1], t_0)
r = [L.subs(temp2[-1]) for L in temp]
d = int(r[0])
m = power_mod(int(Kryptogram3) ,d ,n)
m = str(m)
answer = ""
tempList = [m[x]+m[x+1] for x in range(0,len(m),2)]
for n in tempList:
    answer += Asve[int(n)-1]
print("RSA -", answer)




︡0baba348-063b-48d7-851b-b6a8fc6e3d52︡{"stdout":"förskjutning - tärningenärkastad\n"}︡{"stdout":"PlayFair - dontspillthebeansx\n"}︡{"stdout":"Transposition - ALLTÄRINTEGULDSOMGLIMMAR\n"}︡{"stdout":"Affint - elakaspionerknäckerhemligameddelanden\n"}︡{"stdout":"Monoalfabetiskt - hoolabandoolabandvemkanmanlitapå\n"}︡{"stdout":"Vignere - lurigadiplomaterfixarfred\n"}︡{"stdout":"Hill - jamesbondlurarskurkarmestheladagenxx\n"}︡{"stdout":"Enigma - ENGANSKAANDEFATTIGOCHKORTTEXT\n"}︡{"stdout":"ADFGVX - thisyear2023\n"}︡{"stdout":"DES - Surt, sa räven om rönnbären.    \n"}︡{"stdout":"RSA - spillintebönorna\n"}︡{"done":true}
︠db080a28-d6e8-4006-9a24-dafa0433e917i︠
%md
## Uppgift 2
︡35cc9c79-ed1e-45d0-9bcd-6931243202b0︡{"done":true,"md":"## Uppgift 2"}
︠52bb38bf-5aaf-455c-a82d-4e90917ad68d︠

load('kryptogram.sage') #få ut nyckel + klartext
d = 27 #kryptogram_27

print(kryptogram_27)
decrypted = '-' * len(kryptogram_27)

listedKryptogram_27 = list(kryptogram_27)
listedDecrypted = list(decrypted)

i = 0
while i < len(listedKryptogram_27):
    if listedKryptogram_27[i] == 'f':
        listedDecrypted[i] = 'n'
    elif listedKryptogram_27[i] == 'p':
        listedDecrypted[i] = 'e'
    elif listedKryptogram_27[i] == 'b':
        listedDecrypted[i] = 'h'
    elif listedKryptogram_27[i] == 'ä':
        listedDecrypted[i] = 'a'
    elif listedKryptogram_27[i] == 'q':
        listedDecrypted[i] = 't'
    elif listedKryptogram_27[i] == 's':
        listedDecrypted[i] = 'i'
    elif listedKryptogram_27[i] == 'm':
        listedDecrypted[i] = 'l'
    elif listedKryptogram_27[i] == 'l':
        listedDecrypted[i] = 'v'
    elif listedKryptogram_27[i] == 'd':
        listedDecrypted[i] = 'd'
    elif listedKryptogram_27[i] == 'x':
        listedDecrypted[i] = 'r'
    elif listedKryptogram_27[i] == 'a':
        listedDecrypted[i] = 'm'
    elif listedKryptogram_27[i] == 'j':
        listedDecrypted[i] = 'g'
    elif listedKryptogram_27[i] == 'e':
        listedDecrypted[i] = 's'
    elif listedKryptogram_27[i] == 'o':
        listedDecrypted[i] = 'p'
    elif listedKryptogram_27[i] == 'n':
        listedDecrypted[i] = 'ä'
    elif listedKryptogram_27[i] == 'ö':
        listedDecrypted[i] = 'k'
    elif listedKryptogram_27[i] == 'c':
        listedDecrypted[i] = 'o'
    elif listedKryptogram_27[i] == 'i':
        listedDecrypted[i] = 'c'
    elif listedKryptogram_27[i] == 'k':
        listedDecrypted[i] = 'å'
    elif listedKryptogram_27[i] == 'h':
        listedDecrypted[i] = 'b'
    elif listedKryptogram_27[i] == 'y':
        listedDecrypted[i] = 'ö'
    elif listedKryptogram_27[i] == 't':
        listedDecrypted[i] = 'u'
    elif listedKryptogram_27[i] == 'g':
        listedDecrypted[i] = 'f'
    elif listedKryptogram_27[i] == 'z':
        listedDecrypted[i] = 'j'
    elif listedKryptogram_27[i] == 'u':
        listedDecrypted[i] = 'y'
    #elif listedKryptogram_27[i] == 'r':
        #listedDecrypted[i] = ''
    #elif listedKryptogram_27[i] == 'v':
        #listedDecrypted[i] = ''
    #elif listedKryptogram_27[i] == 'å':
        #listedDecrypted[i] = ''
    i+=1

print()
result_string = ''.join(listedDecrypted)
print(result_string)
print()
#f -> n  gissade
#p -> e  gissade
#b -> h   fick fram 'henne' nu
#ä -> a ?
#q -> t ? baserat på äqq --> att
#s -> i ? baserat på smm --> ill
#m -> l ?
#l -> v ? för att skapa "vill"
#d -> d ? för att skapde "hade"



#x -> r #sista meningen "han visade sig aldrig mer"
#a -> m
#j -> g
#e -> s


#o -> p #göra "rinsessan" till "prinsessan"

#n -> ä #göra "prinsessan när han var"


# göra "draken och prinsessan, det var en gång"
#ö -> k #draken och prinsessan
#c -> o
#i -> c
#k -> å

#resten är rutin arbete


#vrå -> qxz kan inte bestämmas då de aldrig förekommer i texterna


frekvensKrypto = monogramanalys(kryptogram_27) #Ger oss -> p, f, ä, x, q, e (i nämnd ordning) --> e, a, r, n, t, s (i nämnd ordning)
bigramKrypto = bigramanalys(kryptogram_27) #Ger oss -> pf, dp, äf, fe, bä, xä (i nämnd ordning) --> en, er ,de, an, st, ar (i nämnd ordning)
trigramKrypto = trigramanalys(kryptogram_27) #ger oss -> ädp, bäf, jpf, dxä, äöp, xäö (i nämnd ordning)  --> för, och, nde, and, ing, ter, den (i nämnd ordning)

︡58b1e92b-88b1-4aec-9ac6-bc97e67f78ea︡{"stdout":"dxäöpfciboxsfepeeäfdpqläxpfjkfjpfdxäöpecahcddpspfeqcxhcxjbyjqtoopokpqqhpxjdxäöpfbädphcqqdnxsgmpxäqtepfkxapfsfjpfanffseöäbädpepqqbcfcashufecamkjämmdpmpefpdäfgyxhpxjpqoxäqädpedpqauiöpqcalädecaötfdpgsffäeshcxjpfapfsfjpflkjädpesjtoogyxäqqtfdpxeyöädpqdxäöpfbädpläxsqfpxpshufgyxgmpxbtfdxäkxepdäfapfhmslsqeöxnadälöcfeqsjämztddpqläxpflämmoczöpecabädphmkeqsesfgmyzqdxäöpfbädpämdxsjbyxqatesögyxtqcibbäfquiöqpdpqläxgyxeöxniömsjqpfdäjfnxdxäöpfeäqqsesfhcxjcibqsqqädpfpxokhufgsiöbäfeppfläiöpxgmsiöäapdpföxcfäokbtltdpqbäfhmpllnmdsjqönxsbpffpcibqnföqpäqqbpffpeötmmpzäjlsmzäjsgqäasjapdbäflseeqpgyxeqkesfqpläxbcfhcddpapfzäjgkxlnmmpqäpgqpxbpffpqnföqpbäfapfbtxeötmmpbäflkjäesjfpxqsmmhufqnföcadpqbpaeöämztdpqöcasjpfdpqecaanffseöcxfäöämmädpatesöbäfeäamädpacdsgmpxädäjäxepdäfhpjälbäfesjfpxfnxbäföcafpxqsmmhufgcxqeäqqpbäfsfseöcjpfapfsfjpfeqäfeötfdpbäfepbpffpomyqemsjqgsiöbäfeppfoczöpecaöcalnjpfgxäabäfhäxokpqqjplnxdpqläxopxecaläxtqpseöcjpfcibzäjädpfnxopxgsiöepdxäöpfhmplbäfhkdpgyxlkfädcibxndddxäöpfeqäffädpcibgxkjädpläxdpfgsfägmsiöäfapdöxcfäfhcddpapfäxdtoxsfepeeäfekhcxbcfokemcqqpqeläxädpopxdnxpgqpxeöufdädpesjopxbpacibhpxnqqädpgyxämmäbäfayqqpcadxäöpfapfsfjpfqxcddpbcfcadtbäxhäxädxyaqeädpaäfqsmmbcfcapfdäjläxoxsfepeeäfgyxeltffpfaäfmpqädpylpxämmqsbpmädpfeqcxäqxndjkxdpfdnxbcfbädpläxsqcibomciöäqhmcaacxämmäsbpmäemcqqpqmpqädpapfsfjpfeqäfegäffaäfbpffpdkxpdötfjpfeqznfäxpfpxqsmmhufcibeäqqptoopqqeqcxqäfemäjdnxdpqeqcdäqqoxsfepeeäfläxgyxeltffpfötfjpftqmclädppfeqcxhpmyfsfjqsmmdpfecabsqqädpoxsfepeeäffnxopxmneqpäfemäjpqöcabäfäqqqnföäokdxäöpfecabädpgxkjäqpgqpxoxsfepeeäfqnföcadpqläxdxäöpfecabädpxyläqhcxqbpffpopxbädpmteqäqqenqqägtmmgäxqqsmmhcxjpfgyxdpqläxztdsqdxäöpfbädpgyxeltffsqapffnxbäfqnföqppgqpxquiöqpbäfdpqläxhneqäqqlnfqäqsmmedpqhmplayxöqokfäqqpfeayjesjopxtooqsmmhcxjpfapffnxbäföcafnxägsiöbäfepäqqdxäöpfläxläöpfcibeäqqokqxäooäfcibqsqqädpokakfpfomyqemsjqbyxdpepqqgyxeöxniömsjqclnepffkjcföfäiöädpokxtqäfcibeöxpöemnootqasjopxönfdpsjpfoxsfepeeäfexyeqapfbtxeötmmpbäfötffäbznmoäbpffpfnxdxäöpfeäqqcibläöqädphcxjpfapdznafäapmmäfxtaeoxtqädpdxäöpftqpfeqcxpmdemkjädpqekjxteösjqtqopxgsiölnfdäcabpasjpftqäfoxsfepeeäffnxbäfläxbpaaäöcabäfäqqqnföäokäqqbäfbädpepqqpfaäqeökmokqxäooäfötfdpdpqläxädxäöpfeaäqeökmqxcfnxopxläöfädpokacxjcfpfbädpbäfgkqqpfämmdpmpemueäfdpsdpbäfeötmmpeaujätooqsmmhcxjpfsfäqqcibapdesjeötmmpbäfbäeyafapdpmecabäfeötmmpmnjjäsdxäöpfeeökmepdäfeötmmpbäfhpgxsäoxsfepeeäfopxeayjekqueqbäfötfdptooqsmmhcxjpffkjcfdxäöpötfdpbäfsfqpepeötmmpbäflkjäesjgxäaqsmmaäqeökmpfdpqläxämmdpmpemzteqgyxakfpfmueqptoobpmähcxjpfbtxeötmmpbäfjyxäzteqdkgyxeläffakfpfhäöcafkjxäacmfölsiöqeayjopxgxäacibmädpeyafapdpmseökmpfepdäfjyadpbäfesjhäöcafkjxähteöäxciblnfqädpgyxäqqeplädecabnfdppgqpxpfmkfjmkfjeqtfdöcadxäöpftqcibftläxbäflnmdsjqbtfjxsjekbäfemtöädpämmqecagäffeseökmpfepdäfeäqqpbäfesjqsmmxnqqäspfeqcmecaeqcdfpdäfgyxqxäooäfdpqdxyzdpsfqpmnfjpgyxxnfdxäöpfbädpecafäqdpqbyxdpeokdpmztdmsjäefäxöfsfjäxfäbpmähcxjpfeöäöädpölsiöqeayjesjopxsfxteädptoogyxämmäqxäoocxfäqsmmqcxfxtaapqdnxbäfgäffoxsfepeeäfbcfhmplznqqpjmädfnxbcfgsiöepopxecaqcjbpffpebäfdqsmmeäaaäfeeoxäfjdpfpxgyxqxäoocxfäcibgcxqeäqqptqsdpqgxsädxäöpfeclgcxqgäxäfdpecaqtxläxfnxötfjpfcibdxcqqfsfjpfgsiöepesfgmsiöähmpldpznqqpjmädäciböxäaädpcabpffpopxhpxnqqädpcadxäöpfcibbtxbäfbädpmtxäqdpfcibhpgxsäqoxsfepeeäfötfjpfhpxyadpbcfcacibquiöqpäqqbäfbädpläxsqauiöpqacdsjdtgkxgtfdpxäokläddtlsmmbäecahpmyfsfjeäötfjpfapfzäjnxcxcmsjgyxäqqdxäöpföcaapxqsmmhäöäfnxbäftooqniöpxäqqoxsfepeeäfnxhcxqägsffedpqsfjpqecadpfnxxnddgyxzczäjlpqfkjcqeäoxsfepeeäfläddkeäötfjpfzäjtooqniöqpäqqdxäöpfläxlnmdsjqxnddgyxatesöeäoxsfepeeäfdkbäxzäjpfsdpeäopxlsenqqpxpfläöqfpdäfgyxhpxjpqecahyxzäxeopmäatesöekgcxqdxäöpfnxoklnjfpxlsmöpfeaäxqsdpapflsgkxepqsmmäqqecmdäqpxfämyepxälläxäfdxäeäötfjpffkopxbäxdtqnföqokläddtlsmmbäshpmyfsfjeädxcqqfsfjpfzäzäjeötmmpjnxfälsmzäjsgqäasjapdoxsfepeeäfeäopxlädenjpxdtasfgmsiöäeäötfjpfefnmmäoäooädpqlsmmzäjjnxfäeäoxsfepeeäfdtgkxoxsfepeeäfcibbämläötfjäxsöpqpgqpxecadtbäxläxsqekacdsjeäötfjpfepdäfjsgqpesjopxapdoxsfepeeäfcibekmpldpdpmuiömsjäsämmäesfädäjäxtfdxäxdtylpxdxäöpfzcbäflseädpesjämdxsjapx\n"}︡{"stdout":"\n"}︡{"stdout":"drakenochprinsessandetvarengångendrakesomboddeienstorborghögtuppepåettbergdrakenhadebottdärifleratusenårmeningenmänniskahadesetthonomibynsomlågalldelesnedanförbergetpratadesdetmycketomvadsomkundefinnasiborgenmeningenvågadesiguppförattundersökadetdrakenhadevaritnereibynförflerhundraårsedanmenblivitskrämdavkonstigaljuddetvarenvallpojkesomhadeblåstisinflöjtdrakenhadealdrighörtmusikförutochhantycktedetvarförskräckligtendagnärdrakensattisinborgochtittadenerpåbynfickhanseenvackerflickamedenkronapåhuvudethanblevväldigtkärihenneochtänkteatthenneskullejagviljagiftamigmedhanvissteförståsintevarhonboddemenjagfårvälletaefterhennetänktehanmenhurskullehanvågasignertillbyntänkomdethemskaljudetkomigendetsommänniskornakallademusikhansamlademodifleradagarsedanbegavhansignernärhankomnertillbynfortsattehaniniskogenmeningenstanskundehansehenneplötsligtfickhanseenpojkesomkomvägenframhanbarpåettgevärdetvarpersomvaruteiskogenochjagadenärperficksedrakenblevhanbådeförvånadochrädddrakenstannadeochfrågadevardenfinaflickanmedkronanboddemenarduprinsessansåborhonpåslottetsvaradeperdärefterskyndadesigperhemochberättadeförallahanmötteomdrakenmeningentroddehonomduharbaradrömtsademantillhonomendagvarprinsessanförsvunnenmanletadeöveralltiheladenstoraträdgårdendärhonhadevaritochplockatblommorallaihelaslottetletademeningenstansfannmanhennedåredkungenstjänarenertillbynochsatteuppettstortanslagdärdetstodattprinsessanvarförsvunnenkungenutlovadeenstorbelöningtilldensomhittadeprinsessannärperlästeanslagetkomhanatttänkapådrakensomhadefrågatefterprinsessantänkomdetvardrakensomhaderövatborthenneperhadelustattsättafullfarttillborgenfördetvarjuditdrakenhadeförsvunnitmennärhantänkteeftertycktehandetvarbästattväntatillsdetblevmörktpånattensmögsigperupptillborgenmennärhankomnärafickhanseattdrakenvarvakenochsattpåtrappanochtittadepåmånenplötsligthördesettförskräckligtoväsennågonknackadepårutanochskreksläpputmigperkändeigenprinsessansröstmenhurskullehankunnahjälpahennenärdrakensattochvaktadeborgenmedjämnamellanrumsprutadedrakenutenstoreldslågadetsågruskigtutperfickvändaomhemigenutanprinsessannärhanvarhemmakomhanatttänkapåatthanhadesettenmatskålpåtrappankundedetvaradrakensmatskåltronärpervaknadepåmorgonenhadehanfåttenalldeleslysandeidehanskullesmygaupptillborgeninattochmedsigskullehanhasömnmedelsomhanskulleläggaidrakensskålsedanskullehanbefriaprinsessanpersmögsåtysthankundeupptillborgennågondrakekundehaninteseskullehanvågasigframtillmatskålendetvaralldelesljustförmånenlysteupphelaborgenhurskullehangörajustdåförsvannmånenbakomnågramolnkvicktsmögperframochladesömnmedeliskålensedangömdehansigbakomnågrabuskarochväntadeförattsevadsomhändeefterenlånglångstundkomdrakenutochnuvarhanväldigthungrigsåhanslukadealltsomfannsiskålensedansattehansigtillrättaienstolsomstodnedanförtrappandetdröjdeintelängeförrändrakenhadesomnatdethördespådeljudligasnarkningarnahelaborgenskakadekvicktsmögsigperinrusadeuppförallatrappornatilltornrummetdärhanfannprinsessanhonblevjättegladnärhonficksepersomtoghenneshandtillsammanssprangdenerförtrappornaochfortsatteutidetfriadrakensovfortfarandesomturvarnärkungenochdrottningenficksesinflickablevdejättegladaochkramadeomhenneperberättadeomdrakenochhurhanhadeluratdenochbefriatprinsessankungenberömdehonomochtyckteatthanhadevaritmycketmodigdufårfunderapåvadduvillhasombelöningsakungenmenjagäroroligförattdrakenkommertillbakanärhanupptäckerattprinsessanärbortafinnsdetingetsomdenärräddförjojagvetnågotsaprinsessanvaddåsakungenjagupptäckteattdrakenvarväldigträddförmusiksaprinsessandåharjagenidesapervisätterenvaktnedanförbergetsombörjarspelamusiksåfortdrakenärpåvägnervilkensmartidemenvifårsetillattsoldaternalöseravvarandrasakungennåperhardutänktpåvadduvillhaibelöningsadrottningenjajagskullegärnaviljagiftamigmedprinsessansapervadsägerduminflickasakungensnällapappadetvilljaggärnasaprinsessandufårprinsessanochhalvakungariketeftersomduharvaritsåmodigsakungensedangiftesigpermedprinsessanochsålevdedelyckligaiallasinadagarundrarduöverdrakenjohanvisadesigaldrigmer\n"}︡{"stdout":"\n"}︡{"file":{"filename":"/tmp/tmpix87czyx/tmp_pyhx61cy.svg","show":true,"text":null,"uuid":"bce0c63e-0eac-4ed9-bde0-ba846b44b73e"},"once":false}︡{"stdout":"pf  :  119\ndp  :  108\näf  :  96\nfe  :  67\nbä  :  66\nxä  :  64\näd  :  63\npx  :  55\nqq  :  50\npq  :  45\nmm  :  44\näx  :  44\nsf  :  44\nca  :  43\npe  :  43\näö  :  42\neä  :  42\nlä  :  41\näq  :  40\nep  :  40\njp  :  39\nqp  :  39\nsj  :  35\nöp  :  35\ndx  :  35\n"}︡{"stdout":"ädp"}︡{"stdout":"  :  48\nbäf  :  43\njpf  :  32\ndxä  :  29\näöp  :  27\nöpf  :  26\ncib  :  26\nxäö  :  26\nläx  :  25\nfep  :  25\ngyx  :  24\npfe  :  24\näqq  :  24\ndpq  :  23\näfe  :  21\neca  :  21\nepe  :  20\nsmm  :  19\nfjp  :  19\nxsf  :  19\nopx  :  19\neäf  :  19\noxs  :  18\nsfe  :  18\neeä  :  18\n"}︡{"done":true}
︠46182d01-c1f5-479f-91cf-4da70e6de5a3︠
# Skriv in din lösning här.
# Klicka på det horisontella linjen mellan två celler för att infoga fler celler.
%md
## Uppgift 3 eller 4
︡13f6872e-e317-4d41-8e7d-f31ce9ed2dcc︡{"done":true,"md":"## Uppgift 3 eller 4"}
︠790c4dcd-6beb-4ad4-8dee-6541a8e6d9d3︠
#bägare A och bägare B, ska bli C
#REGLER
#a > b
#a > c
#b != c

#ax - by =    (x och y positiv)

#return [s,x,y] s = steg



def tvennekannor(a,b,c, visa_steg = True):
    if(c%(gcd(a,b)) == 0): #Villkor om det går att lösa eller inte

        (d, x0, y0) = xgcd(a, b) # a x0 + b y0 = d
        q = c // d # c = d q
        x0 = x0 * q
        y0 = y0 * q
        x0 = x0
        y0 = y0

        jug_a = 0
        jug_b = 0
        i = 0
        while(jug_a != c and jug_b != c):
            jug_a = a
            if(visa_steg):
                print("Fyll A(", jug_a, jug_b, ")")
            i+=1
            while(jug_a != 0 and jug_a != c and jug_b != c):

                while(jug_a > 0 and jug_b < b):
                    jug_a-=1
                    jug_b+=1
                if(visa_steg):
                    print("Häll över från A till B(", jug_a, jug_b, ")")
                i+=1

                if(jug_b == b and jug_a != c and jug_b != c):
                    jug_b = 0
                    i+=1
                    if(visa_steg):
                        print("Töm B (", jug_a, jug_b, ")")


        if jug_a == c:
            print("Önskade mängden finns nu i A")
        else:
            print("Önskade mängden finns nu i B")

        print("\nAntal steg:" , i)



        print("\nEn lösning på den diofantiska ekvationen är")
        print(a,"x -",b,"y =",c)
        print("är (x,y) = (",abs(x0),",",abs(y0),")")
    else:
        print("Det går inte att mäta upp" , c , "liter med tillgängliga bägare.")
        return[]

    return[i,abs(x0),abs(y0)]

#b)
tvennekannor(26,17,11, True)

#c)
tvennekannor(10872,2114,6091, False) #går ej
tvennekannor(10872,4321,6091, False) # [26844,4355065,10957709]
tvennekannor(10872,6885,6091, False) #går ej
︡10500ef5-cb6d-4e42-a0f4-1684c562e13e︡{"stdout":"Fyll A( 26 0 )\nHäll över från A till B( 9 17 )\nTöm B ( 9 0 )\nHäll över från A till B( 0 9 )\nFyll A( 26 9 )\nHäll över från A till B( 18 17 )\nTöm B ( 18 0 )\nHäll över från A till B( 1 17 )\nTöm B ( 1 0 )\nHäll över från A till B( 0 1 )\nFyll A( 26 1 )\nHäll över från A till B( 10 17 )\nTöm B ( 10 0 )\nHäll över från A till B( 0 10 )\nFyll A( 26 10 )\nHäll över från A till B( 19 17 )\nTöm B ( 19 0 )\nHäll över från A till B( 2 17 )\nTöm B ( 2 0 )\nHäll över från A till B( 0 2 )\nFyll A( 26 2 )\nHäll över från A till B( 11 17 )\nÖnskade mängden finns nu i A\n\nAntal steg: 22\n\nEn lösning på den diofantiska ekvationen är\n26 x - 17 y = 11\när (x,y) = ( 22 , 33 )\n[22, 22, 33]\n"}︡{"stdout":"Det går inte att mäta upp 6091 liter med tillgängliga bägare.\n[]\n"}︡{"stdout":"Önskade mängden finns nu i A"}︡{"stdout":"\n\nAntal steg: 26844\n\nEn lösning på den diofantiska ekvationen är\n10872 x - 4321 y = 6091\när (x,y) = ( 4355065 , 10957709 )\n[26844, 4355065, 10957709]\n"}︡{"stdout":"Det går inte att mäta upp 6091 liter med tillgängliga bägare.\n[]\n"}︡{"done":true}
︠450be4d6-2acc-4e14-894e-c0291b2ccef4︠









