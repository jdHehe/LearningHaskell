{-
1. Pattern Match 模式匹配的方式
 -}
--单行注释
sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe x = "Not between 1 and 5"

--定义factorial函数
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial(n-1)

--定义二元组操作函数
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors a b = (fst a + fst b, snd a + snd b)
--addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)

--自定义head'函数，获取list的第一个元素
head' :: [a] -> a
head' [] = error "Can't call head on an empty list, dummy!"
head' (x:_) = x

--自定义length'函数，获取list的长度, [_:xs] 和 (_:xs)有什么区别
length' :: (Num b) => [a] -> b
length' [] = 0
length' (_:xs) = 1 + length' xs

--自定义求和函数， 注意与上面的函数的区别，这里的函数的接收到list存储的数据也要是Num
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

--Guard 的例子
bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
  | bmi <= 18.5 = "You're underweight, you emo, you"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat !Lose some weight , fatty!"
  | otherwise = "You're a whale, congratulations!"

bmiTell2 :: (RealFloat a) => a -> a -> String
bmiTell2 weight height
  | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
  | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise                 = "You're a whale, congratulations!"

myCompare' :: (Ord a) => a -> a -> Ordering
myCompare' a b
  | a > b     = GT
  | a == b    = EQ
  | otherwise = LT

-- where的用法
initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = firstname
          (l:_) = lastname

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2
