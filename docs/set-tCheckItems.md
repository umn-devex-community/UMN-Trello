---
external help file: umn-trello-help.xml
Module Name: umn-trello
online version: 
schema: 2.0.0
---

# Set-TCheckItems

## SYNOPSIS
Update check item state

## SYNTAX

```
Set-TCheckItems [-appKey] <String> [-token] <String> [-cardID] <String> [-idCheckItem] <String>
 [-state] <String> [<CommonParameters>]
```

## DESCRIPTION
For setting the state of a check item on a check list to complete of incomplete

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
$return = Set-TCheckItems -appKey 'cb6c8d2993cf5f4432de1224c67' -token $token -idCheckItem $idCheckItem -cardID $cardID
```

## PARAMETERS

### -appKey
Application key from trello.
Retrieved from trello.com/app-key

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

### -token
User authentication token.
Retrieved from trello.com/app-key, or call Get-TAuthToken

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

### -cardID
card ID of a card on a board.

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

### -idCheckItem
ID of a check list item on a check list on a card on a board.

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

### -state
state to set the item to.
complete or incomplete

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 5
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

