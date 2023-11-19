$utilisateurs = Import-Csv -Path "C:\CSV\users.csv"
$domain = "3TL2-1.lab"

foreach ($utilisateur in $utilisateurs) {
    $nom = $utilisateur.Nom
    $prenom = $utilisateur.Prenom
    $login = $utilisateur.Login
    $email = $utilisateur.Email
    $motDePasse = $utilisateur.MotDePasse

    Write-Host "Création de l'utilisateur : $prenom $nom ($login)"

    try {
        New-ADUser -Name "$prenom $nom" -SamAccountName $login -UserPrincipalName "$login@$domain" -GivenName $prenom -Surname $nom -EmailAddress $email -AccountPassword (ConvertTo-SecureString -AsPlainText $motDePasse -Force) -Enabled $true -ErrorAction Stop
        Write-Host "Utilisateur créé avec succès : $prenom $nom ($login)"
    } catch {
        Write-Host "Erreur lors de la création de l'utilisateur : $prenom $nom ($login)"
        Write-Host $_.Exception.Message
    }

}

Write-Host "Les utilisateurs ont été créés avec succès."