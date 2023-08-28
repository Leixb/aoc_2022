module Main where

newtype Path = Path [String] deriving (Show)
data FileTree = File String Int | Directory String [FileTree] deriving (Show)

data State = State FileTree Path deriving (Show)
instance Eq FileTree where
    (File name1 _) == (File name2 _) = name1 == name2
    (Directory name1 _) == (Directory name2 _) = name1 == name2
    _ == _ = False

getName :: FileTree -> String
getName (File name _) = name
getName (Directory name _) = name

size :: FileTree -> Int
size (File _ s) = s
size (Directory _ ts) = sum $ map size ts

isDir :: FileTree -> Bool
isDir (Directory _ _) = True
isDir _ = False

add :: FileTree -> FileTree -> FileTree
add dir@(Directory name ts) filetree
    | filetree `elem` ts = dir
    | otherwise = Directory name $ ts ++ [filetree]
add File{} _ = error "Cannot add to file"

buildDirPath :: Path -> FileTree
buildDirPath (Path [leaf]) = Directory leaf []
buildDirPath (Path (d:ds)) = Directory d [buildDirPath (Path ds)]
buildDirPath (Path []) = undefined

replace :: FileTree -> Path -> FileTree -> FileTree
replace ft (Path []) new = add ft new
replace ft (Path [_]) new = add ft new
replace ft@(Directory name files) (Path (d:ds)) new
    | d `elem` map getName files = let
            replace_matching dir = if getName dir == d then replace dir (Path ds) new else dir in
        Directory name $ map replace_matching files
    | otherwise = add ft $ buildDirPath $ Path $ d:ds

cd :: State -> Path -> State
cd (State tree cwd) (Path []) = State tree cwd
cd (State tree cwd) (Path ["/"]) = State tree (Path [])
cd (State tree (Path cwd)) (Path (d:ds))
    | d == ".." = cd (State tree (Path (init cwd))) (Path ds)
    | otherwise = cd (State tree (Path (cwd ++ [d]))) (Path ds)

ls :: State -> String -> State
ls state@(State fs cwd@(Path p)) entry
    | w == "dir" = State (replace fs target (Directory name [])) cwd
    | otherwise = let weight = read w :: Int in
        State (replace fs target (File name weight)) cwd
    where
        (w:name:args) = words entry
        target = Path $ p++[name]

runCommands :: [String] -> State -> State
runCommands [] state = state
runCommands (line:lines) state
    | w == "$" && name == "cd" = runCommands lines $ cd state (Path args)
    | w == "$" && name == "ls" = runCommands lines state
    | otherwise = runCommands lines $ ls state line
    where (w:name:args) = words line

filterDirSize :: Int -> FileTree -> [FileTree]
filterDirSize limit dir@(Directory _ ts)
    | size dir <= limit = dir : concatMap (filterDirSize limit) ts
    | otherwise = concatMap (filterDirSize limit) ts
filterDirSize _ _ = []

runAll :: String -> String
runAll input = let State ft _ = runCommands (lines input) $ State (Directory "/" []) (Path [])
    in show $ sum $ map size $ filterDirSize 100000 ft

main :: IO ()
main = interact runAll >> putStr "\n"
