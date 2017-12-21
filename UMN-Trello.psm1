# Copyright 2017 University of Minnesota, Office of Information Technology

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>. 

# Based off 
# https://developers.trello.com/reference


#region Auth Trello
function Get-TAuthToken{
    <#
        .Synopsis
            Used to get a user auth token

        .DESCRIPTION
            Authentication tokens are used along with the app key for all API calls.

        .PARAMETER appKey
            Application key from Trello. Retrieved from trello.com/app-key.

        .PARAMETER appName
            The name exposed to the Trello API for authorization.

        .PARAMETER expiration
            Length of time token is valid for. Never is an option. What ever you want it to be.
                    
        .PARAMETER scope
            Permision scope comma delimited . read,write,account

        .EXAMPLE
            $token = Get-TAuthToken -expiration 'never' -scope 'read,write,account' -appKey 'cb6c8d2993cf5f4432de1224c67' -appName 'powerShell'
        
            
        .Notes
            Author: Kyle Weeks
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [string]$appKey,

        [Parameter(Mandatory)]
        [string]$appName,

        [Parameter(Mandatory)]
        [string]$expiration,

        [Parameter(Mandatory)]
        [string]$scope

    )

    Begin{
        $baseURI = 'https://api.trello.com/1/'
    }

    Process
    {
        $api = "authorize?expiration=$expiration&scope=$scope&response_type=token&name=$appName&key=$appKey"
        $uri = $baseURI + $api

        ### Get the token
        $approval_prompt = "force"
        $ie = New-Object -comObject InternetExplorer.Application
        if($approval_prompt -eq "force"){$ie.visible = $true}
        $null = $ie.navigate($uri)

        #Wait for user interaction in IE, manual approval
        do{Start-Sleep 1}until($ie.LocationURL -match 'https://trello.com/1/token/approve')
        $token = (((($ie.Document.body.innerHTML -replace "`t|`n|`r |  ","") -split "<pre>")[1]).Split("<"))[0]
        $null = $ie.Quit()
         
    }
    End{
        return $token
    }
}

#endregion


#region Get Trello
function Get-TBoardCardList{
    <#
        .Synopsis
            Return list of cards on a board

        .DESCRIPTION
            Usefull to get a list of all cards on a board

        .PARAMETER appKey
            Application key from trello. Retrieved from trello.com/app-key.

        .PARAMETER token
            User authentication token. Retrieved from trello.com/app-key, or call Get-TAuthToken
                    
        .PARAMETER boardID
            id of a board.

        .EXAMPLE
            $return = Get-TBoardCardList -appKey 'cb6c8d2993cf5f4432de1224c67' -token $token -boardID $boardID
        
            
        .Notes
            Author: Kyle Weeks
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [string]$appKey,

        [Parameter(Mandatory)]
        [string]$token,

        [Parameter(Mandatory)]
        [string]$boardID  
    )

    Begin{
        $auth = "&key=$appKey&token=$token"
        $baseURI = 'https://api.trello.com/1/'
    }

    Process
    {
        $api = "boards/$boardID/cards/?fields=name&members=true&member_fields=fullName"
        $uri = $baseURI + $api + $auth
        $cards = Invoke-RestMethod -Method Get -Uri $uri       
    }
    End{
        return $cards
    }
}

function Get-TBoardCheckLists{
    <#
        .Synopsis
            Return list of checkLists on a board

        .DESCRIPTION
            Usefull to get a list of all checkList data on a board

        .PARAMETER appKey
            Application key from trello. Retrieved from trello.com/app-key

        .PARAMETER token
            User authentication token. Retrieved from trello.com/app-key, or call Get-TAuthToken
                    
        .PARAMETER boardID
            board ID of a board.

        .EXAMPLE
            $return = Get-TCardCheckLists -appKey 'cb6c8d2993cf5f4432de1224c67' -token $token -boardID $boardID
        
            
        .Notes
            Author: Kyle Weeks
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [string]$appKey,

        [Parameter(Mandatory)]
        [string]$token,

        [Parameter(Mandatory)]
        [string]$boardID    
    )

    Begin{
        $auth = "&key=$appKey&token=$token"
        $baseURI = 'https://api.trello.com/1/'
    }

    Process
    {
        $api = "boards/$boardID/checklists?checkItem_fields=name&fields=name"
        $uri = $baseURI + $api + $auth
        $checklists = Invoke-RestMethod -Method Get -Uri $uri
       
    }
    End{
        return $checkLists
    }
}

function Get-TCardCheckLists{
    <#
        .Synopsis
            Return list of checkLists on a card

        .DESCRIPTION
            Usefull to get a list of all checkList data for a trello card on a board

        .PARAMETER appKey
            Application key from trello. Retrieved from trello.com/app-key

        .PARAMETER token
            User authentication token. Retrieved from trello.com/app-key, or call Get-TAuthToken
                    
        .PARAMETER cardID
            cardID on a board.

        .EXAMPLE
            $return = Get-TCardCheckLists -appKey 'cb6c8d2993cf5f4432de1224c67' -token $token -cardID $cardID
        
            
        .Notes
            Author: Kyle Weeks
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [string]$appKey,

        [Parameter(Mandatory)]
        [string]$token,

        [Parameter(Mandatory)]
        [string]$cardID    
    )

    Begin{
        $auth = "&key=$appKey&token=$token"
        $baseURI = 'https://api.trello.com/1/'

    }

    Process
    {
        $api = "cards/$cardID/checklists?key=$appKey&token=$token"
        $uri = $baseURI + $api
        $checkLists = Invoke-RestMethod -Method Get -Uri $uri
    }
    End{
        return $checkLists
    }
}

function Get-TCheckItems{
    <#
        .Synopsis
            Return list of items on a check list

        .DESCRIPTION
            Usefull to get a list of all idCheckItem IDs of items on a checkList

        .PARAMETER appKey
            Application key from trello. Retrieved from trello.com/app-key

        .PARAMETER token
            User authentication token. Retrieved from trello.com/app-key, or call Get-TAuthToken
                    
        .PARAMETER idCheckList
            checkList ID of a checklist on a card on a board.

        .EXAMPLE
            $return = Get-TCardCheckLists -appKey 'cb6c8d2993cf5f4432de1224c67' -token $token -idCheckList $idCheckList
        
            
        .Notes
            Author: Kyle Weeks
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [string]$appKey,

        [Parameter(Mandatory)]
        [string]$token,

        [Parameter(Mandatory)]
        [string]$idCheckList    
    )

    Begin{
        $auth = "&key=$appKey&token=$token"
        $baseURI = 'https://api.trello.com/1/'
    }

    Process
    {
        $api = "checklists/$idCheckList/checkItems?"
        $uri = $baseURI + $api + $auth
        $checkItems = Invoke-RestMethod -Method Get -Uri $uri
    }
    End{
        return $checkItems
    }
}

function Get-Trello{
    <#
        .Synopsis
            Super basic query function.

        .DESCRIPTION
            Starting point for getting any information out of Trello.

        .PARAMETER appKey
            Application key from trello. Retrieved from trello.com/app-key

        .PARAMETER token
            User authentication token. Retrieved from trello.com/app-key, or call Get-TAuthToken
                    
        .PARAMETER query
            Query for anything your user has access to on Trello.

        .EXAMPLE
            $return = Get-Trello -appKey 'cb6c8d2993cf5f4432de1224c67' -token $token -query 'Name of a board'
        
            
        .Notes
            Author: Kyle Weeks
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [string]$appKey,

        [Parameter(Mandatory)]
        [string]$token,

        [Parameter(Mandatory)]
        [string]$query    
    )

    Begin{
        $auth = "&key=$appKey&token=$token"
        $baseURI = 'https://api.trello.com/1/'

    }

    Process
    {
        $api = "search?query=$query"
        $uri = $baseURI + $api + $auth
        $return = Invoke-RestMethod -Method Get -Uri $uri
       
    }
    End{
        return $return
    }
}
#endregion



#region Set Trello
function Set-TCheckItems{
    <#
        .Synopsis
            Update check item state

        .DESCRIPTION
            For setting the state of a check item on a check list to complete of incomplete

        .PARAMETER appKey
            Application key from trello. Retrieved from trello.com/app-key

        .PARAMETER token
            User authentication token. Retrieved from trello.com/app-key, or call Get-TAuthToken
                    
        .PARAMETER idCheckItem
            ID of a check list item on a check list on a card on a board.
                    
        .PARAMETER cardID
            card ID of a card on a board.

        .PARAMETER state
            state to set the item to. complete or incomplete

        .EXAMPLE
            $return = Set-TCheckItems -appKey 'cb6c8d2993cf5f4432de1224c67' -token $token -idCheckItem $idCheckItem -cardID $cardID
        
            
        .Notes
            Author: Kyle Weeks
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory)]
        [string]$appKey,

        [Parameter(Mandatory)]
        [string]$token,

        [Parameter(Mandatory)]
        [string]$cardID,  
          
        [Parameter(Mandatory)]
        [string]$idCheckItem,

        [Parameter(Mandatory)]
        [ValidateSet('complete','incomplete')]
        [string]$state
        
    )

    Begin{
        $auth = "&key=$appKey&token=$token"
        $baseURI = 'https://api.trello.com/1/'
    }

    Process
    {
        $api = "cards/$cardID/checkItem/$idCheckItem"+"?state=$state"
        $uri = $baseURI + $api + $auth
        $return = Invoke-RestMethod -Method Put -Uri $uri
       
    }
    End{
        return $checkItems
    }
}

#endregion