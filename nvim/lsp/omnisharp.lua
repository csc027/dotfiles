return {
	flags = { debounce_text_changes = 150 },
	handlers = {
		['textDocument/definition'] = require('omnisharp_extended').definition_handler,
		['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
		['textDocument/references'] = require('omnisharp_extended').references_handler,
		['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler
	},
	settings = {
		FormattingOptions = {
			EnableEditorConfigSupport = true,
			OrganizeImports = true
		},
		MsBuild = {
			LoadProjectsOnDemand = false
		},
		RoslynExtensionsOptions = {
			EnableAnalyzersSupport = true,
			EnableImportCompletion = true,
			AnalyzeOpenDocumentsOnly = false,
			EnableDecompilationSupport = true
		},
		RenameOptions = {
			RenameInComments = false,
			RenameOverloads = true,
			RenameInStrings = false
		},
		Sdk = {
			IncludePrereleases = true
		}
	}
}
