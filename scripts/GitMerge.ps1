param (
    [Parameter(Mandatory=$true)]
    [string]
    $GitRepoName,

    [Parameter(Mandatory=$true)]
    [string]
    $GitSourceBranch,

    [Parameter(Mandatory=$true)]
    [string]
    $GitTargetBranch
  )

# cd "$($env:System_DefaultWorkingDirectory)/$($GitRepoName)"

cd "$($env:Pipeline_Workspace)/$($GitRepoName)" # Modifying the path to point to the <Pipeline_Workspace>/<GitRepoName>

# git fetch
git fetch
if (-not $?) {
  Write-Host(" git fetch failed");
  exit 1
}

# git checkout to target branch
git checkout $($GitTargetBranch)
if (-not $?) {
  Write-Host(" git checkout $($GitTargetBranch) failed");
  exit 1
}

# pull changes from source branch
git pull origin $($GitSourceBranch) --allow-unrelated-histories
if (-not $?) {
  Write-Host(" git pull origin $($GitSourceBranch) --allow-unrelated-histories failed");
  exit 1
}

# push changes from target branch
git push origin $($GitTargetBranch)
if (-not $?) {
  Write-Host("git push origin $($GitTargetBranch) failed");
  exit 1
}
