local powershell_es_bundle_path = ''
local psscriptanalyzer_settings_path = ''
if (
	powershell_es_bundle_path ~= nil and powershell_es_bundle_path ~= '' and
	psscriptanalyzer_settings_path ~= nil and psscriptanalyzer_settings_path ~= ''
) then
	return {
		bundle_path = powershell_es_bundle_path,
		init_options = { enableProfileLoading = false },
		settings = { powershell = { scriptAnalysis = { settingsPath = psscriptanalyzer_settings_path } } }
	}
end
