-- JoinByJob (versão DEBUG + instruções) -- Salve como arquivo .lua raw (por ex. GitHub raw) e carregue com: -- loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU_USUARIO/REPO/main/JoinByJob.lua"))() -- OU cole diretamente num LocalScript em StarterGui (recomendado no Roblox Studio sem executores).

-- ======== CONFIGURAÇÃO ======== local AUTO_EXECUTE = false -- true para executar o código baixado automaticamente local RAW_URL = "https://raw.githubusercontent.com/SEU_USUARIO/REPO/main/JoinByJob.lua" -- troque pelo seu raw URL

local function fetchWithFallback(url) -- tenta múltiplos métodos usados por diferentes executores local body, status local ok, err = pcall(function() if type(syn) == "table" and syn.request then local r = syn.request({Url = url, Method = "GET"}) body = r.Body; status = r.StatusCode elseif _G.request then local r = request({Url = url, Method = "GET"}) body = r.Body; status = r.StatusCode elseif http and http.request then local r = http.request({Url = url, Method = "GET"}) body = r.body or r.Body; status = r.statusCode or r.StatusCode elseif game and game.HttpGet then body = game:HttpGet(url) status = 200 else error("Nenhum método HTTP detectado no ambiente") end end) return ok, body, status or 0, err end

-- Função de debug: baixa, mostra resumo e opcionalmente executa local function debugLoad(url) print("[JoinByJob DEBUG] Tentando baixar: ", url) local ok, body, status, err = fetchWithFallback(url) if not ok then warn("[JoinByJob DEBUG] Erro ao baixar: ", tostring(body) or tostring(err)) return false, tostring(body) or tostring(err) end

if not body or #tostring(body) == 0 then
    warn("[JoinByJob DEBUG] Conteúdo vazio retornado. Status:", tostring(status))
    return false, "conteudo vazio"
end

-- mostra as primeiras linhas para inspeção rápida
local snippet = tostring(body):sub(1, 1024)
print("[JoinByJob DEBUG] Conteúdo (início):

" .. snippet) print("[JoinByJob DEBUG] Comprimento do conteúdo:", #tostring(body), "Status:", tostring(status))

if AUTO_EXECUTE then
    print("[JoinByJob DEBUG] AUTO_EXECUTE= true -> executando o arquivo baixado")
    local ok2, err2 = pcall(function()
        local f = assert(loadstring(body))
        f()
    end)
    if not ok2 then
        warn("[JoinByJob DEBUG] Erro ao executar: ", tostring(err2))
        return false, tostring(err2)
    end
    return true
else
    print("[JoinByJob DEBUG] AUTO_EXECUTE = false -> não será executado automaticamente. Se o download estiver OK, altere AUTO_EXECUTE para true para executar.")
    return true
end

end

-- Execução automática do debug (quando este arquivo for carregado) local ok, err = pcall(function() return debugLoad(RAW_URL) end) if not ok then warn("[JoinByJob DEBUG] Falha no debugLoad: ", tostring(err)) end

-- ======== INSTRUÇÕES RÁPIDAS ======== -- 1) Verifique o raw URL: abra o RAW_URL no navegador. Deve abrir o código .lua em texto puro. Se abrir HTML/404/redirect, corrija o link. -- 2) Se você estiver no Roblox Studio padrão: NÃO use loadstring(game:HttpGet(...)) — cole o código do arquivo direto num LocalScript em StarterGui. -- 3) Se estiver usando um executor (checar permissões): rode este arquivo pelo executor e veja os prints/erros no console do executor. -- 4) Se o fetch falhar com mensagem "Nenhum método HTTP detectado": seu executor/ambiente não expõe funções HTTP para scripts de cliente. -- 5) Se o fetch funcionar mas a teleporte falhar: o TeleportService pode retornar erro por JobId inválido/servidor privado. Confira o JobId e tente um JobId de servidor público.

-- ======== Observações de segurança ======== -- Executar código remoto implica riscos: tenha certeza de confiar no conteúdo do URL que você está carregando. -- Se preferir, cole o código manualmente no Studio (LocalScript) em vez de usar loaders remotos.

-- FIM

