module Main where

newtype Path = Path [String] deriving (Show)
data FileTree = File String Int | Directory String [FileTree] deriving (Show)

data State = State FileTree Path deriving (Show)

add :: FileTree -> FileTree -> FileTree
add filetree dir@(Directory name ts) =
    if filetree `elem` ts then dir else Directory name $ ts ++ [filetree]

instance Eq FileTree where
    (File name1 _) == (File name2 _) = name1 == name2
    (Directory name1 _) == (Directory name2 _) = name1 == name2
    _ == _ = False

buildDirPath :: Path -> FileTree
buildDirPath (Path [leaf]) = Directory leaf []
buildDirPath (Path (d:ds)) = Directory d [buildDirPath (Path ds)]
buildDirPath (Path []) = undefined

getName :: FileTree -> String
getName (File name _) = name
getName (Directory name _) = name

isDir :: FileTree -> Bool
isDir (Directory _ _) = True
isDir _ = False

replace :: FileTree -> Path -> FileTree -> FileTree
replace ft (Path []) new = add new ft
replace ft (Path ["/"]) new = add new ft
replace ft (Path [leaf]) new = add new ft
replace ft@(Directory name files) (Path (d:ds)) new
    | d `elem` map getName files = Directory name $ map (\dir ->
        if getName dir == d then
            replace dir (Path ds) new
        else
            dir
        ) files
    | otherwise = add (buildDirPath (Path (d:ds))) ft

size :: FileTree -> Int
size (File _ s) = s
size (Directory _ ts) = sum $ map size ts

cd :: State -> Path -> State
cd (State tree cwd) (Path []) = State tree cwd
cd (State tree cwd) (Path ["/"]) = State tree (Path [])
cd (State tree (Path cwd)) (Path (d:ds)) =
    if d == ".." then
        cd (State tree (Path (init cwd))) (Path ds)
    else
        cd (State tree (Path (cwd ++ [d]))) (Path ds)

command :: State -> String -> [String] -> State
command state "cd" args = cd state (Path args)
command state "ls" [] = state

runCommands :: [String] -> State -> State
runCommands [] state = state
runCommands (line:lines) state =
    let (w:name:args) = words line in
    runCommands lines $ if w == "$" then
        command state name args
    else
        ls state line

ls :: State -> String -> State
ls state@(State fs cwd@(Path p)) entry =
    let (w:name:args) = words entry
        target = Path $ p++[name]
    in
    if w == "dir" then
        State (replace fs target (Directory name [])) cwd
    else
        let weight = read w :: Int in
        State (replace fs target (File name weight)) cwd

filterDirSize :: Int -> FileTree -> [FileTree]
filterDirSize limit dir@(Directory _ ts) =
    if size dir >= limit then
        dir : concatMap (filterDirSize limit) ts
    else
        concatMap (filterDirSize limit) ts
filterDirSize _ _ = []

runAll :: String -> String
runAll input = let
    State ft _ = runCommands (lines input) (State (Directory "/" []) (Path []))
    total = size ft
    free = 70000000 - total
    needed = 30000000
    have_to_remove = needed - free
    candidates = map size $ filterDirSize have_to_remove ft
    in show $ minimum candidates

main :: IO ()
main = interact runAll
