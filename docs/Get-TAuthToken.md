---
external help file: umn-trello-help.xml
Module Name: umn-trello
online version: 
schema: 2.0.0
---

# Get-TAuthToken

## SYNOPSIS
Used to get a user auth token

## SYNTAX

```
Get-TAuthToken [-appKey] <String> [-appName] <String> [-expiration] <String> [-scope] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Authentication tokens are used along with the app key for all API calls.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$token = Get-TAuthToken -expiration 'never' -scope 'read,write,account' -appKey 'cb6c8d2993cf5f4432de1224c67' -appName 'powerShell'
```

## PARAMETERS

### -appKey
Application key from Trello.
Retrieved from trello.com/app-key.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -appName
The name exposed to the Trello API for authorization.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expiration
Length of time token is valid for.
Never is an option.
What ever you want it to be.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scope
Permision scope comma delimited .
read,write,account

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Kyle Weeks

## RELATED LINKS

