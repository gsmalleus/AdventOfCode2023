$puzzleInput = get-content $PSScriptRoot/input.txt

$partOneAnswer = 0
$regex = '[0-9]'

foreach ($line in $puzzleInput) {
	$matchFirst = [regex]::Match($line, $regex)
	$matchLast = [regex]::Match($line, $regex, 'RightToLeft') 
	$partOneAnswer += [int]($matchFirst.ToString() + $matchLast.ToString())
}

Write-Host "Part One Answer: $partOneAnswer"

#### Part 2 #####
$partTwoAnswer = 0

$regex = ('[0-9]|one|two|three|four|five|six|seven|eight|nine|zero')

foreach ($line in $puzzleInput) {
	$matchFirst = [regex]::Match($line, $regex)
	$matchLast = [regex]::Match($line, $regex, 'RightToLeft') 

	$matchFirst = switch ($matchFirst) {
		"one" { "1"; break }
		"two" { "2"; break }
		"three" { "3"; break }
		"four" { "4"; break }
		"five" { "5"; break }
		"six" { "6"; break }
		"seven" { "7"; break }
		"eight" { "8"; break }
		"nine" { "9"; break }
		"zero" { "0"; break }
		default { $matchFirst }
	}
	$matchLast = switch ($matchLast) {
		"one" { "1"; break }
		"two" { "2"; break }
		"three" { "3"; break }
		"four" { "4"; break }
		"five" { "5"; break }
		"six" { "6"; break }
		"seven" { "7"; break }
		"eight" { "8"; break }
		"nine" { "9"; break }
		"zero" { "0"; break }
		default { $matchLast }
	}

	$partTwoAnswer += [int]($matchFirst.ToString() + $matchLast.ToString())
}

Write-Host "Part Two Answer: $partTwoAnswer"