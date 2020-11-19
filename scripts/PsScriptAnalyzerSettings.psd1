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
		PSAvoidTrailingWhitespace = @{ Enable = $true };
		PSAvoidUsingDoubleQuotesForConstantString = @{ Enable = $true };
		PSAvoidUsingCmdletAliases = @{ Enable = $true };
		PSMisleadingBacktick = @{ Enable = $true };
		PSProvideCommentHelp = @{ Enable = $true };
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
		PSUseCorrectCasing = @{ Enable = $true };
	}
}
