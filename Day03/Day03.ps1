#get schematic
$schematic = get-content $PSScriptRoot/input.txt

#set schematic max size
$maxRows = $schematic.Length
$maxCols = $schematic[0].Length

#iterators start at [row 0][col 0]
$r = 0
$c = 0

#initialize sum of parts to 0
$partSum = 0

do {
	#check if current position is a number
	if ([regex]::Match($schematic[$r][$c].toString(), '[0-9]').Success) {
		
		$partNumLength = 1

		#check to the right to see how many digits in a row
		while ([regex]::Match($schematic[$r][$c + $partNumLength], '[0-9]').Success -and ($c + $partNumLength -le $maxCols)) {
			$partNumLength ++
		}
		
		#part number is current position to the number of consecutive digits
		[int]$partNumber = $schematic[$r].ToString().Substring($c, $partNumLength)

		#if the number starts in the left most column start the check from the current column, else start one column to the left
		if ($c - 1 -lt 0) { $checkCol = $c }
		else { $checkCol = $c - 1 }

		#set the length to check one less if the number is along the right most column
		if (($c + $partNumLength) -ge $maxCols) { $checkLength = $partNumLength + 1 }
		else { $checkLength = $partNumLength + 2 }

		$partFound = $false

		#check the row before, the current row, and the next row for a parts symbol
		for ($i = -1; $i -le 1; $i ++) {

			#check if the row before or after is out of bounds
			if (($r + $i -ge 0) -and ($r + $i -lt $maxRows)) {

				#if substring contains a parts symbol then part is found
				if ([regex]::Match($schematic[$r + $i].ToString().Substring($checkCol, $checkLength), '[^0-9\.]').Success) {
					$partFound = $true
					break
				}
			}
		}

		#if part was found, add it to the sum of found parts
		if ($partFound) { $partSum += $partNumber }
		
		#move column iterator to the column after the current part number
		$c = $c + $partNumLength
	}

	#increment row if at end of line, else move one column right
	if (($c + 1) -ge $maxCols) {
		$c = 0
		$r ++
	}
	else {
		$c++
	}

} while ($r -lt $maxRows)

Write-Host "Schematic Part Sum: $partSum"