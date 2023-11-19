$utilisateurs = Import-Csv -Path "C:\CSV\users.csv"
$domain = "3TL2-1.lab"

foreach ($utilisateur in $utilisateurs) {
    $nom = $utilisateur.Nom
    $prenom = $utilisateur.Prenom
    $login = $utilisateur.Login
    $email = $utilisateur.Email
    $motDePasse = $utilisateur.MotDePasse

    Write-Host "Cr�ation de l'utilisateur : $prenom $nom ($login)"

    try {
        New-ADUser -Name "$prenom $nom" -SamAccountName $login -UserPrincipalName "$login@$domain" -GivenName $prenom -Surname $nom -EmailAddress $email -AccountPassword (ConvertTo-SecureString -AsPlainText $motDePasse -Force) -Enabled $true -ErrorAction Stop
        Write-Host "Utilisateur cr�� avec succ�s : $prenom $nom ($login)"
    } catch {
        Write-Host "Erreur lors de la cr�ation de l'utilisateur : $prenom $nom ($login)"
        Write-Host $_.Exception.Message
    }

}

Write-Host "Les utilisateurs ont �t� cr��s avec succ�s."