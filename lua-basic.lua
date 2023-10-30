-- 두 개의 연속된 대쉬는 그 대쉬가 있는 한 줄을 주석으로 처리합니다.

--[[
    ‘--[[‘는 여러 줄 주석의 시작을 
    ‘--]]’는 여러 줄 주석의 끝을 뜻합니다.
--]]

----------------------------------------------------
-- 1. 변수와 흐름 제어.
----------------------------------------------------
 

num = 42  -- 모든 수는 double 형입니다.
-- 겁먹지 마십시오, 64 bit double 형에는 정확한 정수 값을 저장할 수 있는 52 bit가 있습니다.
-- 52 bit 보다 작은 크기로 표현할 수 있는 정수에 대해서는 정밀도 문제가 생기지 않습니다.

s = 'walternate'  -- 파이썬(Python) 같은 바꿀 수 없는 문자열.
t = "쌍 따옴표도 쓸 수 있습니다."
u = [[ 이중 대괄호는
      여러 줄 문자열의
      시작과 끝을 나타냅니다.]]
t = nil  -- t를 정의되지 않은 변수로 만듭니다. 루아에는 가비지 컬렉션 기능이 있습니다.

-- 블록은 do와 end로 표기됩니다.
while num < 50 do
 num = num + 1      -- ‘++’ 또는 ’+=’ 연산자는 없습니다.
end

-- If 절:
if num > 40 then
 print('over 40')
elseif s ~= 'walternate' then  -- ‘~=’는 같지 않음을 뜻합니다.
 -- 파이썬 같이 같음을 확인하는 연산자는 ‘==’입니다. ‘==’는 문자열에도 사용될 수 있습니다.
 io.write('not over 40\n')  -- 기본적으로 stdout으로 출력됩니다.
else
 -- 변수들은 기본적으로 전역(global) 변수로 만들어집니다.
 thisIsGlobal = 5  -- 변수 이름을 표기할 때는 낙타 등 표기법이 흔히 사용됩니다.

 -- 변수를 지역(local) 변수로 만드는 방법:
 local line = io.read()  -- 다음 stdin 줄을 읽습니다.

 -- ‘..’ 연산자를 사용하여 문자열 잇기:
 print('Winter is coming, ' .. line)    -- Winter is coming + ‘stdin으로 입력한 문자열’ 출력.
end

-- 정의되지 않은 변수들은 nil을 리턴합니다.
-- 이것은 에러가 아닙니다:
foo = anUnknownVariable  -- foo에 anUnknownVariable(한 정의되지 않은 변수)를 넣습니다. 이제 foo = nil.

aBoolValue = false

-- 불(boolean) 연산에서는 오직 nil과 false만 거짓입니다. 0 과 '' 는 참입니다!
if not aBoolValue then print('twas false') end

-- 'or'와 'and'는 short-circuit 됩니다.
-- 다음은 C/자바스크립트에서의 a?b:c 연산자와 비슷합니다.
ans = aBoolValue and 'yes' or 'no'  --> 'no'

karlSum = 0
for i = 1, 100 do  -- 그 범위의 양 끝을 포함합니다.
 karlSum = karlSum + i
end

-- "100, 1, -1"를 쓰면 범위를 감소하도록 정할 수 있습니다.
fredSum = 0
for j = 100, 1, -1 do

 fredSum = fredSum + j 

end

-- 일반적으로, 범위는 시작, 끝[, 증가 또는 감소량] 입니다.

-- 또 다른 루프 작성법: 
repeat
 print('the way of the future')
 num = num - 1
until num == 0


----------------------------------------------------
-- 2. 함수.
----------------------------------------------------

function fib(n)                        -- 피보나치 수
 if n < 2 then return 1 end
 return fib(n - 2) + fib(n - 1)    -- 재귀 함수 
end

-- 함수 안에 정의된 함수(closure)와 이름 없는 함수도 쓸 수 있습니다.
function adder(x)  -- 리턴되는 함수는 adder가 호출될 때 생성됩니다. 그리고 x의 값을 기억합니다.
 return function (y) return x + y end 
end
a1 = adder(9)    -- adder가 처음 호출되었으므로 a1에 9가 들어갑니다.
a2 = adder(36)  -- adder가 처음 호출되었으므로 a2에 36이 들어갑니다.
print(a1(16))     -- a1에는 9가 들어있습니다. 

                         -- 거기서 다시 a1 인스턴스 adder를 호출하였으므로, 9+16=25가 출력됩니다.
print(a2(64))     -- a2에는 36이 들어있습니다. 

                          -- 거기서 다시 a2 인스턴스 adder를 호출하였으므로, 36+64=100이 출력됩니다.

-- 리턴, 함수 호출, 그리고 할당은 모두 리스트로 동작합니다. 그 리스트의 길이는 다를 수도 있습니다.
-- 매치되지 않는 수신자들은 nil로 취급됩니다. 매치되지 않는 전송자들은 버려집니다.

x, y, z = 1, 2, 3, 4
-- x = 1, y = 2, z = 3입니다. 4 는 버려집니다.

function bar(a, b, c)
 print(a, b, c)
 return 4, 8, 15, 16, 23, 42
end

x, y = bar('zaphod')  --> "zaphod  nil nil"이 출력됩니다.
-- x = 4, y = 8이 할당됩니다. 값 15, 16, 23, 42 는 버려집니다.

-- 함수는 first-class입니다, 함수는 지역 또는 전역일 수 있습니다.
-- 다음 두 줄은 같습니다:
function f(x) return x * x end
f = function (x) return x * x end

-- 그리고 다음 두 줄도 같습니다:
local function g(x) return math.sin(x) end
local g; g = function (x) return math.sin(x) end
-- 'local g' 선언은 g를 자기 참조 가능하게 만듭니다.

-- 삼각 함수들은 라디안으로 동작합니다.

-- 매개변수에 한 문자열만 들어갈 때는 (함수를 호출할 때) 괄호를 붙이지 않아도 됩니다.:
print 'hello'  -- 잘 동작합니다.


----------------------------------------------------
-- 3. 테이블.
----------------------------------------------------

-- 테이블은 루아의 유일한 합성 자료 구조입니다.
-- 테이블은 연관 배열(associative arrays)입니다.
-- php 배열 또는 자바스크립트 객체와 비슷합니다.
-- 테이블은 리스트로도 사용될 수 있는 해시 참조 사전입니다.

-- 테이블을 사전이나 맵(map)으로 사용하기.

-- 사전은 기본적으로 문자열 키(key)를 가집니다.
t = {key1 = 'value1', key2 = false}

-- 문자열 키는 자바스크립트 같은 점 표기를 쓸 수 있습니다.
print(t.key1)  -- 'value1' 출력.
t.newKey = {}  -- 새로운 key/value 쌍 추가.
t.key2 = nil   -- 테이블 t에서 key2 제거.

-- 키로 (nil이 아닌) 임의의 표기를 사용할 수도 있습니다.
u = {['@!#'] = 'qbert', [{}] = 1729, [6.28] = 'tau'}
print(u[6.28])  -- "tau" 출력

-- 키 매칭은 기본적으로 숫자와 문자열 값으로 수행됩니다.
-- 그러나 테이블은 동질성(identity)에 의해 수행됩니다.
a = u['@!#']  -- a = 'qbert'
b = u[{}]        -- 1729가 들어갈 것으로 기대했지만, 실제로 들어가는 값은 nil입니다. b = nil. 
-- 이유는 검색이 실패하기 때문입니다.
-- 검색 실패 이유는 우리가 사용한 키가 원래 값을 저장할 때 사용된 것과 같은 객체가 아니기 때문입니다.
-- 그래서 더 이식성 높은 키는 문자열과 숫자입니다.

-- 매개변수가 테이블 하나인 함수 호출에서는 괄호가 필요 없습니다.
function h(x) print(x.key1) end
h{key1 = 'Sonmi~451'}  -- 'Sonmi~451' 출력.

for key, val in pairs(u) do  -- 테이블 반복.
 print(key, val)
end

-- _G 는 모든 전역들(globals)을 위한 특별한 테이블입니다.
print(_G['_G'] == _G)  -- 'true' 출력.

-- 테이블을 리스트 또는 배열로 사용하기.

-- 리스트는 암묵적으로 정수형 키를 설정합니다.
v = {'value1', 'value2', 1.21, 'gigawatts'}
for i = 1, #v do  -- #v 는 리스트 v의 크기(size)입니다.
 print(v[i])  -- 인덱스는 1부터 시작합니다.
end
-- 리스트는 실제 타입이 아닙니다. v는 그저 하나의 테이블입니다.
-- 이 테이블은 연속적인 정수 키를 가지며, 리스트로 취급됩니다.
 


----------------------------------------------------
-- 3.1 메타테이블과 메타메소드
----------------------------------------------------
-- 테이블 하나는 메타테이블 하나를 가질 수 있습니다.
-- 그 메타테이블은 연산자 오버로딩을 제공합니다.
-- 나중에 우리는 어떻게 메타테이블이 자바스크립트의 프로토타입 동작을 지원하는지 볼 것입니다.

f1 = {a = 1, b = 2}  -- 분수 a/b를 표현.
f2 = {a = 2, b = 3}

-- 이것은 실패할 것입니다. (분수에 대한 덧셈은 루아에 정의되어 있지 않기 때문입니다.)
-- s = f1 + f2

metafraction = {}
function metafraction.__add(f1, f2)
 sum = {}
 sum.b = f1.b * f2.b
 sum.a = f1.a * f2.b + f2.a * f1.b
 return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2  -- f1의 메타테이블에 있는 __add(f1,f2)를 호출합니다.

-- f1, f2는 자바스크립트의 프로토타입과 달리 메타테이블에 키가 없습니다.
-- 그래서 당신은 반드시 그 키들을 getmetatable(f1)과 같이 다시 받아와야 합니다.
-- 그 메타테이블은 루아가 그것에 대해 아는 키를 가진 보통 테이블입니다. __add 같이요.

-- 그러나 다음 줄은 실패합니다. 왜냐하면, s에는 메타테이블이 없기 때문입니다.
-- t = s + s
-- 아래 주어진 클래스 같은 패턴들이 이 문제를 해결합니다.

-- 메타테이블에서 __index는 (myFavs.animal에 있는 점 처럼) 점 참조를 오버로드합니다.
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.animal  -- 동작합니다! 메타테이블, 고마워요.

-- 직접적 테이블 검색이 실패하면, (검색은) 그 메타테이블의 __index 값을 사용하여 다시 시도됩니다.
-- 그리고 이것이 반복됩니다.

-- 한 __index 값은 또한 더 사용자가 원하는 대로 맞춰진(customized) 검색을 위한 함수(테이블, 키)일 수 있습니다.

-- (add 같은) __index의 값들은 메타메소드라 불립니다.
-- 메타메소드의 전체 목록입니다. 여기서 a는 메타메소드를 가진 한 테이블입니다.

-- __add(a, b)                  for a + b
-- __sub(a, b)                  for a - b
-- __mul(a, b)                  for a * b
-- __div(a, b)                  for a / b
-- __mod(a, b)                  for a % b
-- __pow(a, b)                  for a ^ b
-- __unm(a)                     for -a
-- __concat(a, b)               for a .. b
-- __len(a)                     for #a
-- __eq(a, b)                   for a == b
-- __lt(a, b)                   for a < b
-- __le(a, b)                   for a <= b
-- __index(a, b) <함수 또는 테이블>  for a.b
-- __newindex(a, b, c)          for a.b = c
-- __call(a, ...)               for a(...)
 


----------------------------------------------------
-- 3.2 클래스 같은 테이블 그리고 상속.
----------------------------------------------------
-- 클래스는 (루아에) 내장되어 있지 않습니다. 클래스는 테이블과 메타테이블을 사용하여 만들어집니다.

-- 그 예제와 설명은 아래와 같습니다.

Dog = {}                                                     -- 1.

function Dog:new()                                  -- 2.
 newObj = {sound = 'woof'}                       -- 3.
 self.__index = self                                    -- 4.
 return setmetatable(newObj, self)         -- 5.
end

function Dog:makeSound()                    -- 6.
 print('I say ' .. self.sound)
end

mrDog = Dog:new()                                  -- 7.
mrDog:makeSound()  -- 'I say woof'         -- 8.

-- 1. Dog는 클래스처럼 동작합니다. 사실 Dog는 테이블입니다.
-- 2. function 테이블이름:함수(...)는 function 테이블이름.함수(self,...)와 같습니다.
--    ‘:’은 단지 함수의 첫 인자에 self를 추가합니다.
--    어떻게 self가 값을 얻는지는 아래 7과 8을 읽으십시오.
-- 3. newObj(새 객체)는 클래스 Dog의 한 인스턴스가 될 것입니다.
-- 4. self = 인스턴스로 될 클래스.
--    흔히 self = Dog입니다, 그러나 상속으로 그것이 바뀔 수 있습니다.
--    우리가 newObj의 메타테이블과 self의 __index를 self로 설정하면,
--    newObj는 self의 함수들을 얻습니다.
-- 5. 기억하세요: setmetatable은 그것의 첫 인자를 리턴합니다.
-- 6. ‘:’는 2처럼 동작합니다. 그러나 이번에는 self가 클래스가 아닌 인스턴스가 되리라고 예상할 수 있습니다.
-- 7. Dog:new()는 Dog.new(Dog)와 같습니다. 그래서 new()에서 self=Dog입니다.
-- 8. mrDog:makeSound()는 mrDog.makeSound(mrDog)와 같습니다. 여기서 self=mrDog입니다.


----------------------------------------------------

-- 상속 예제:
[Reference] : 졸리운_곰, 「1日 30分 인생승리의 학습 - 루아 15분 안에 배우기」 https://www.stechstar.com/user/zbxe/?mid=min30&document_srl=55466.






LoudDog = Dog:new()                                        -- 1.

function LoudDog:makeSound()
 s = self.sound .. ' '                                             -- 2.
 print(s .. s .. s)
end

seymour = LoudDog:new()                                -- 3.
seymour:makeSound()  -- 'woof woof woof'      -- 4.

-- 1. LoudDog는 Dog의 메소드들과 변수들을 가져옵니다.
-- 2. self는 new()에서 온 ‘sound’ 키를 가집니다. 3을 보십시오.
-- 3. LoudDog:new()는 LoudDog.new(LoudDog)와 같습니다.
--    그리고 LoudDog.new(LoudDog)는 Dog.new(LoudDog)로 변환됩니다. 

--    LoudDog에 ‘new’ 키가 없기 때문입니다.
--    그러나 LoudDog는 그 메타테이블에 __index=Dog를 가집니다.
--    결과: seymour의 메타테이블은 LoudDog입니다, 그리고 LoudDog.__index = LoudDog. 

--    그래서 seymour.key는 seymour.key, LoudDog.key, Dog.key 중 

--    주어진 키를 가진 첫번 째 테이블일 것입니다. 
-- 4. 'makeSound' 키는 LoudDog에서 찾을 수 있습니다.
--     seymour:makeSound()는 LoudDog.makeSound(seymour)와 같습니다.



-- 만약 필요하면, 하위 클래스의 new()는 기본 클래스의 것처럼 만들 수 있습니다.
function LoudDog:new()
 newObj = {}
 -- newObj 설정
 self.__index = self
 return setmetatable(newObj, self)
end
 


----------------------------------------------------
-- 4. 모듈.
----------------------------------------------------

--[[ 저는 이 스크립트의 나머지 부분이 실행 가능한 상태로 남도록 

--   이 절(section)을 주석으로 처리하고 있습니다. 

 
-- mod.lua 파일이 다음과 같다고 가정합시다.

local M = {}

local function sayMyName()
 print('Hrunkner')
end

function M.sayHello()
 print('Why hello there')
 sayMyName()
end

return M


-- 다른 파일도 mod.lua 파일에 있는 기능을 사용할 수 있습니다.
local mod = require('mod')  -- mod.lua 파일 실행.

-- require는 모듈을 포함(include)하게 하는 표준 방법입니다.
-- require는 이렇게 동작합니다. (만약 캐쉬되지 않으면요. '캐쉬되다'의 뜻은 아래에서 다시 설명됩니다.)
local mod = (function ()
 <mod.lua 파일의 내용>
end)()
-- mod.lua는 한 함수에 들어있는 내용처럼 한 지역 변수 mod에 대입됩니다. 

-- 그래서 mod.lua 안에 있는 지역 변수와 지역 함수들은 그 함수 밖에서는 보이지 않게됩니다.

-- mod는 mod.lua의 M과 같기 때문에, 다음은 동작합니다.
mod.sayHello()  -- Hrunkner에게 안녕이라고 말합니다.

-- 지역 함수인 sayMyName은 오직 mod.lua 안에서만 존재하므로, 다음은 틀렸습니다.
mod.sayMyName()  -- 에러

-- require의 리턴 값들은 캐쉬되어 require가 여러 번 호출되더라도 한 파일은 한번만 실행됩니다.
-- 예를 들어, mod2.lua가 "print('Hi!')”를 포함한다고 가정합시다.
local a = require('mod2')  -- Hi! 출력
local b = require('mod2')  -- 출력 안함; a=b.

-- dofile은 require와 비슷하지만 캐싱을 하지 않습니다.
dofile('mod2.lua')  --> Hi!
dofile('mod2.lua')  --> Hi! (다시 실행합니다.)

-- loadfile은 루아 파일을 로드하지만 아직 실행하지는 않습니다.
f = loadfile('mod2.lua')  -- mod2.lua를 실행하기 위해서는 f()를 호출해야 합니다.

-- loadstring은 문자열을 위한 loadfile입니다.
g = loadstring('print(343)')  -- 한 함수를 리턴합니다.
g()  -- 343을 출력합니다; 이 함수가 호출되기 전까지는 아무것도 출력되지 않습니다.

--]]

----------------------------------------------------
-- 5. 참고 자료
----------------------------------------------------
 

--[[
 

저는 루아를 배우는 것이 정말 좋았습니다. 그래서 저는 Löve 2D 게임 엔진으로 게임들도 만들 수 있었습니다. 그것이 제가 루아를 공부한 이유입니다. 

 
저는 BlackBulletIV's Lua for programmers를 보며 루아 공부를 시작하였습니다. 그다음 Programming in Lua 책을 읽었습니다. 그것이 제가 루아를 공부한 방법입니다. 

 
lua-users.org에 있는 Lua short reference를 확인해보는 것도 도움이 될 수 있습니다.
 

여기서 다루지 않은 주요 주제들은 표준 라이브러리들입니다:
* string library
* table library
* math library
* io library
* os library
 

어쨌든, 이 문서 파일 전체는 하나의 유효한 루아 파일입니다. 이 문서를 learn.lua로 저장하고 “lua learn.lua”로 실행해 보십시오! 

 
이 글은 tylerneylon.com을 위해 처음 쓰였습니다. 이 글은 또한 github gist로 보실 수도 있습니다. 이 글과 형식은 같지만 다른 언어로 쓰인 글들은 여기에서 보실 수 있습니다. 

 
http://learnxinyminutes.com/ 

루아와 함께 즐거운 시간 되십시오!

--]]
[Reference] : 졸리운_곰, 「1日 30分 인생승리의 학습 - 루아 15분 안에 배우기」 https://www.stechstar.com/user/zbxe/?mid=min30&document_srl=55466.