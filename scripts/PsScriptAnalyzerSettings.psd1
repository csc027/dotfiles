@{
	IncludeRules = @(
		'PSAvoidAssignmentToAutomaticVariable',
		'PSAvoidDefaultValueForMandatoryParameter',
		'PSAvoidDefaultValueSwitchParameter',
		'PSAvoidGlobalAliases',
		'PSAvoidGlobalFunctions',
		'PSAvoidGlobalVars',
		'PSAvoidInvokingEmptyMembers',
		'PSAvoidNullOrEmptyHelpMessageAttribute',
		'PSAvoidOverwritingBuiltInCmdlets',
		'PSAvoidShouldContinueWithoutForce',
		'PSAvoidTrailingWhitespace',
		'PSAvoidUsingCmdletAliases',
		'PSAvoidUsingComputerNameHardcoded',
		'PSAvoidUsingConvertToSecureStringWithPlainText',
		'PSAvoidUsingDeprecatedManifestFields',
		'PSAvoidUsingDoubleQuotesForConstantString',
		'PSAvoidUsingEmptyCatchBlock',
		'PSAvoidUsingInvokeExpression',
		'PSAvoidUsingPlainTextForPassword',
		'PSAvoidUsingPositionalParameters',
		'PSAvoidUsingUsernameAndPasswordParams',
		'PSAvoidUsingWMICmdlet',
		'PSAvoidUsingWriteHost',
		'PSMisleadingBacktick',
		'PSMissingModuleManifestField',
		'PSPlaceCloseBrace',
		'PSPlaceOpenBrace',
		'PSPossibleIncorrectComparisonWithNull',
		'PSPossibleIncorrectUsageOfAssignmentOperator',
		'PSPossibleIncorrectUsageOfRedirectionOperator',
		'PSProvideCommentHelp',
		'PSReservedCmdletChar',
		'PSReservedParams',
		'PSReviewUnusedParameter',
		'PSShouldProcess',
		'PSUseApprovedVerbs',
		'PSUseBOMForUnicodeEncodedFile',
		'PSUseCmdletCorrectly',
		'PSUseConsistentIndentation',
		'PSUseConsistentWhitespace',
		'PSUseCorrectCasing',
		'PSUseDeclaredVarsMoreThanAssignments',
		'PSUseLiteralInitializerForHashtable',
		'PSUseOutputTypeCorrectly',
		'PSUseProcessBlockForPipelineCommand',
		'PSUsePSCredentialType',
		'PSUseSingularNouns',
		'PSUseSupportsShouldProcess',
		'PSUseToExportFieldsInManifest',
		'PSUseUsingScopeModifierInNewRunspaces',
		'PSUseUTF8EncodingForHelpFile'
	)
	Rules = @{
		PSAvoidAssignmentToAutomaticVariable = @{ Enable = $true }
		PSAvoidDefaultValueForMandatoryParameter = @{ Enable = $true }
		PSAvoidDefaultValueSwitchParameter = @{ Enable = $true }
		PSAvoidGlobalAliases = @{ Enable = $true }
		PSAvoidGlobalFunctions = @{ Enable = $true }
		PSAvoidGlobalVars = @{ Enable = $true }
		PSAvoidInvokingEmptyMembers = @{ Enable = $true }
		PSAvoidNullOrEmptyHelpMessageAttribute = @{ Enable = $true }
		PSAvoidOverwritingBuiltInCmdlets = @{ Enable = $true }
		PSAvoidShouldContinueWithoutForce = @{ Enable = $true }
		PSAvoidTrailingWhitespace = @{ Enable = $true }
		PSAvoidUsingCmdletAliases = @{ Enable = $true }
		PSAvoidUsingComputerNameHardcoded = @{ Enable = $true }
		PSAvoidUsingConvertToSecureStringWithPlainText = @{ Enable = $true }
		PSAvoidUsingDeprecatedManifestFields = @{ Enable = $true }
		PSAvoidUsingDoubleQuotesForConstantString = @{ Enable = $true }
		PSAvoidUsingEmptyCatchBlock = @{ Enable = $true }
		PSAvoidUsingInvokeExpression = @{ Enable = $true }
		PSAvoidUsingPlainTextForPassword = @{ Enable = $true }
		PSAvoidUsingPositionalParameters = @{ Enable = $true }
		PSAvoidUsingUsernameAndPasswordParams = @{ Enable = $true }
		PSAvoidUsingWMICmdlet = @{ Enable = $true }
		PSAvoidUsingWriteHost = @{ Enable = $true }
		PSMisleadingBacktick = @{ Enable = $true }
		PSMissingModuleManifestField = @{ Enable = $true }
		PSPossibleIncorrectComparisonWithNull = @{ Enable = $true }
		PSPossibleIncorrectUsageOfAssignmentOperator = @{ Enable = $true }
		PSPossibleIncorrectUsageOfRedirectionOperator = @{ Enable = $true }
		PSProvideCommentHelp = @{ Enable = $true }
		PSReservedCmdletChar = @{ Enable = $true }
		PSReservedParams = @{ Enable = $true }
		PSReviewUnusedParameter = @{ Enable = $true }
		PSShouldProcess = @{ Enable = $true }
		PSUseApprovedVerbs = @{ Enable = $true }
		PSUseBOMForUnicodeEncodedFile = @{ Enable = $true }
		PSUseCmdletCorrectly = @{ Enable = $true }
		PSUseCorrectCasing = @{ Enable = $true }
		PSUseDeclaredVarsMoreThanAssignments = @{ Enable = $true }
		PSUseLiteralInitializerForHashtable = @{ Enable = $true }
		PSUseOutputTypeCorrectly = @{ Enable = $true }
		PSUseProcessBlockForPipelineCommand = @{ Enable = $true }
		PSUsePSCredentialType = @{ Enable = $true }
		PSUseSingularNouns = @{ Enable = $true }
		PSUseSupportsShouldProcess = @{ Enable = $true }
		PSUseToExportFieldsInManifest = @{ Enable = $true }
		PSUseUsingScopeModifierInNewRunspaces = @{ Enable = $true }
		PSUseUTF8EncodingForHelpFile = @{ Enable = $true }
		PSPlaceCloseBrace = @{
			Enable = $true;
			IgnoreOneLineBlock = $true;
			NewLineAfter = $false;
			NoEmptyLineBefore = $true;
		};
		PSPlaceOpenBrace = @{
			Enable = $true;
			IgnoreOneLineBlock = $true;
			NewLineAfter = $true;
			OnSameLine = $true;
		};
		PSUseConsistentIndentation = @{
			Enable = $true;
			IndentationSize = 4;
			Kind = 'tab';
			PiplineIndentation = 'NoIndentation';
		};
		PSUseConsistentWhitespace = @{
			Enable = $true
			CheckInnerBrace = $true
			CheckOpenBrace = $true
			CheckOpenParen = $true
			CheckOperator = $true
			CheckPipe = $true
			CheckPipeForRedundantWhitespace = $true
			CheckSeparator = $true
			CheckParameter = $false
		};
	}
}
