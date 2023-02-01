# https://oeis.org/A098550
# Numberphile video: https://www.youtube.com/watch?v=DUaqiM1bGX4

function GCF ([int]$a, [int]$b)
{
    while ($b -ne 0)
    {
        $temp = $b
        $b = $a % $b
        $a = $temp
    }
    $a
}

$YellowStone = [System.Collections.ArrayList]@()
@(1..3).foreach({$YellowStone.Add($_)}) | Out-Null

for ($i = 3; $i -lt 45; $i++)
{
    # item i must not be divisible by the n-1 item
    # item i must be a multiple of he n-2 item
    # item i must not be in the set of previous items
    # item i must be the lowest possible value

    $n = 4 # The first three digits are 1,2,3 so start at 4 being the lowest possible unused value
    while ($true)
    {
        $RelativelyPrime = $false
        $multiple = $false
        $inset = $false

        # Start with the lowest possible value not in the set
        while ( $YellowStone.Contains($n) )
        {
            $n++
        }

        # Is relatively prime to the previous item
        if ((gcf $YellowStone[$i-1] $n) -eq 1) # $n % $YellowStone[$i - 1] -ne 0 -and 
        {
            $RelativelyPrime = $true
        }
        
        # Is a multiple of the n-2 item - This isn't quite right yet
        if ((gcf $YellowStone[$i-2] $n)  -ne 1)
        {
            $multiple = $true
        }

        if ($YellowStone.contains($n))
        {
            $inset = $true
        }

        if ($RelativelyPrime -and $multiple -and -not $inset)
        {
            $YellowStone.Add($n) | Out-Null
            break # out of the while loop
        }
        $n++
    }
}

$YellowStone -join ', '