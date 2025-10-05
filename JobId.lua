-- Roblox: Entrar em servidor por JobId -- Instruções: crie um ScreenGui em StarterGui, coloque este LocalScript dentro do ScreenGui. -- O layout abaixo assume que o ScreenGui tem um Frame com: --  * TextBox named "JobIdBox" --  * TextButton named "JoinButton" --  * TextLabel named "StatusLabel"

local TeleportService = game:GetService("TeleportService") local Players = game:GetService("Players") local player = Players.LocalPlayer local placeId = game.PlaceId -- mesmo PlaceId do jogo atual

local gui = script.Parent local frame = gui:WaitForChild("Frame") local jobIdBox = frame:WaitForChild("JobIdBox") local joinButton = frame:WaitForChild("JoinButton") local statusLabel = frame:WaitForChild("StatusLabel")

-- Função auxiliar: limpa espaços e pega apenas dígitos local function cleanJobId(text) if not text then return nil end local digits = text:match("%d+") return digits end

joinButton.MouseButton1Click:Connect(function() local raw = jobIdBox.Text local jobId = cleanJobId(raw)

if not jobId or #jobId < 5 then
    statusLabel.Text = "JobId inválido. Cole somente o JobId (apenas números)."
    return
end

statusLabel.Text = "Tentando entrar no servidor..."

local ok, err = pcall(function()
    -- Teleporta o jogador para a instância indicada (JobId)
    TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
end)

if not ok then
    statusLabel.Text = "Erro ao teleportar: " .. tostring(err)
end

end)

-- Dica: se quiser pré-preencher com um JobId de exemplo, descomente a linha abaixo -- jobIdBox.Text = "1234567890"


---

-- Layout sugerido (crie manualmente no Roblox Studio se preferir): -- ScreenGui --  Frame --   TextBox (Name = JobIdBox)    -- Placeholder: "Cole JobId aqui" --   TextButton (Name = JoinButton) -- Text = "Entrar" --   TextLabel (Name = StatusLabel) -- Text = "Aguardando..."


---

-- Observações: -- 1) Nem todos os servidores podem ser acessíveis: servidores privados, reservados ou que mudaram de JobId podem não permitir entrada. -- 2) TeleportService pode falhar por restrições de segurança/servidor. O pcall captura o erro e mostra na StatusLabel. -- 3) Isso funciona apenas para teleportar o jogador atual para outra instância do mesmo PlaceId. -- 4) Não use isso para contornar regras de jogo ou acessar servidores restritos.

