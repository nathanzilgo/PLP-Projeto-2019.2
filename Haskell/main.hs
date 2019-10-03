import Graphics.Image.IO


view_selector :: Int -> String
    -- TODO

main :: IO
main = do
    -- Fronteiras de cada estado:
    entrada = do
        let nordeste = readImageRGB VU "nordeste.jpg"
        displayImage nordeste

    front_pb = ["RN", "PE", "CE"]
    front_pe = ["AL", "BA", "PB", "PI", "CE"]
    front_ba = ["SE", "AL", "PE", "PI"]
    front_pi = ["MA", "BA", "CE", "PE"]
    front_ma = ["PI"]
    front_ce = ["RN", "PI", "PE", "PA"]
    front_rn = ["CE", "PA"]
    front_al = ["PE", "SE", "BA"]
    front_se = ["BA", "AL"]

