# Récupérer toutes les versions d'objets
versions=$(aws s3api list-object-versions --bucket thims3 --query='{Objects: Versions[].[VersionId, Key]}')

# Vérifier si des versions existent
if [ "$(echo $versions | jq '.Objects | length')" -gt 0 ]; then
    # Supprimer toutes les versions
    aws s3api delete-objects --bucket thims3 --delete "$versions"
else
    echo "Aucune version d'objet à supprimer."
fi

