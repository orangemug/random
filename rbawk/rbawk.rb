# Some awk style aliases for ruby
alias $OFS  $,  # Output Field Separator
alias $ORS  $\  # Output Record Separator
alias $FS   $;  # Field Separator
alias $RS   $/  # Record Separator
alias $NR   $.  # Number of Records
alias $L    $_  # Current Line

BEGIN {
        # Number of Fields
        $NF = $F.length if $F
}
