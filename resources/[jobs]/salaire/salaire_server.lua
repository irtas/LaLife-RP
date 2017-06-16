-- Loading MySQL Class
require "resources/mysql-async/lib/MySQL"

RegisterServerEvent('paycheck:salary')
AddEventHandler('paycheck:salary', function()
	local salary = math.random(100,250) --Aide de l'État random (ici entre 100 et 250) RP: A changer au bon vouloir du président
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (user) then
			-- Ajout de l'argent à l'utilisateur
			local user_id = user.identifier
			-- Requête qui permet de recuperer le métier de l'utilisateur
			MySQL.Async.fetchScalar("SELECT salary FROM users INNER JOIN jobs ON users.job = jobs.job_id WHERE identifier = @username",{['@username'] = user_id}, function (salary_job)
				if salary_job > 0 then
					user:addMoney((salary + salary_job))
					TriggerClientEvent("citizenv:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "Aide de L'État :  + "..salary.."~g~$~s~~n~Salaire reçu : + "..salary_job.." ~g~$")
				end
			end)
		else
			TriggerEvent("es:desyncMsg")
		end
	end)
end)
