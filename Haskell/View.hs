{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module View where

{-
Visualização de uma realocada de tropas em um user
Params: String nameUser, Int quantidade, String estado1, String estado2
Return: IO() resultado.
-}
realocaTroopsView :: String -> Int -> String -> String -> IO()
realocaTroopsView name quant estado1 estado2
    putStrLn(name ++ " está movendo " ++ quant ++ " tropas de " ++ estado1 ++ " para " ++ estado2)

{-
Visualização de uma remoção de tropas em um user
Params: String nameUsr, Int quantidade, String estado
Return: IO() resultado.
-}
removeTroopsView :: String -> Int -> String -> IO()
removeTroopsView nameUsr quant estado
    putStrLn(nameUsr ++ " está perdendo " ++ quant ++ " tropas de " ++ estado)

