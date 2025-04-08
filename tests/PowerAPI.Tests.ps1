Describe "PowerAPI Tests" {
    It "Fetches /api/profile successfully" {
        { Get-PowerAPI "/api/profile" } | Should -Not -Throw
    }
    It "Autocompletes endpoints" {
        (Get-Command Get-PowerAPI).Parameters["url"].Attributes | 
            Should -BeOfType [System.Management.Automation.ArgumentCompleterAttribute]
    }
}