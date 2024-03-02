function show_default_org
	if test -e './.sfdx/sfdx-config.json'
		set defaultusername "$(cat ./.sfdx/sfdx-config.json 2>/dev/null | jq -r '.defaultusername')"
		test "$defaultusername" != "null"; and test defaultusername != ""
		echo $defaultusername
	else
		echo 'failed:' -f './.sfdx/sfdx-config.json'
	end
end
