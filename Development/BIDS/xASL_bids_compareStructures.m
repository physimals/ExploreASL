function [identical,results] = xASL_bids_compareStructures(pathDatasetA,pathDatasetB)
%xASL_bids_compareStructures Function that compares two BIDS folders with several subfolders and studies and prints the differences.
%
% FORMAT: [identical,results] = xASL_bids_compareStructures(pathDatasetA,pathDatasetB);
%
% INPUT:
%        pathDatasetA       - path to first BIDS structure (REQUIRED)
%        pathDatasetB       - path to second BIDS structure (REQUIRED)
%
% OUTPUT:
%        identical          - Returns 1 if both folder structures are identical and 0 if not
%        results            - structure containing (possible) differences of both folder structures
%
% -----------------------------------------------------------------------------------------------------------------------------------------------------
% DESCRIPTION:      Function that compares two BIDS folders with several subfolders and studies and prints the differences.
%
% -----------------------------------------------------------------------------------------------------------------------------------------------------
%
% EXAMPLE:          pathDatasetA = '...\bids-examples\eeg_rest_fmri';
%                   pathDatasetB = '...\bids-examples\eeg_rest_fmri_exact_copy'
%                   [identical,results] = xASL_bids_compareStructures(pathDatasetA,pathDatasetB);
%
% REFERENCES:       ...
% __________________________________
% Copyright @ 2015-2020 ExploreASL


    %% Input Check

    % Check if both root folders are valid char arrays or strings
    if ~(ischar(pathDatasetA) || isstring(pathDatasetA))
        error('The path of structure A is neither a char array not a string...');
    end
    if ~(ischar(pathDatasetB) || isstring(pathDatasetB))
        error('The path of structure A is neither a char array not a string...');
    end

    % Check if both root folders exists
    if ~(xASL_exist(pathDatasetA)==7)
        error('The root folder of structure A does not exist...');
    end
    if ~(xASL_exist(pathDatasetB)==7)
        error('The root folder of structure B does not exist...');
    end


    %% Defaults

    % Set identical to true (will be set to false as soon as a difference is found)
    identical = true;

    % Initialize results structure
    results = struct;

    %% Initialization

    % Get dataset names
    [~,datasetA,~] = fileparts(pathDatasetA);
    [~,datasetB,~] = fileparts(pathDatasetB);

    % Make sure you have valid identifiers for the field names
    datasetA = matlab.lang.makeValidName(datasetA,'ReplacementStyle','delete');
    datasetB = matlab.lang.makeValidName(datasetB,'ReplacementStyle','delete');
    results.(datasetA) = struct;
    results.(datasetB) = struct;
    
    % Get files and folders of datasets A and B
    filesA = dir(fullfile(pathDatasetA, '**\*.*'));
    filesB = dir(fullfile(pathDatasetB, '**\*.*'));
    
    % Remove root path
    filesA = modifyFileList(filesA,pathDatasetA);
    filesB = modifyFileList(filesB,pathDatasetB);
    
    % Get folder lists
    folderListA = unique(string({filesA.folder}'));
    folderListB = unique(string({filesB.folder}'));
    
    % Get real file lists
    fileListA = unique(string({filesA.name}'));
    fileListB = unique(string({filesB.name}'));
    
    % Missing Folders
    results.(datasetA).missingFolders = setdiff(folderListB,folderListA);
    results.(datasetB).missingFolders = setdiff(folderListA,folderListB);
    
    % Missing Files
    results.(datasetA).missingFiles = setdiff(fileListB,fileListA);
    results.(datasetB).missingFiles = setdiff(fileListA,fileListB);
    
    % Identical check
    if ~isempty(results.(datasetA).missingFolders) || ~isempty(results.(datasetB).missingFolders)
        identical = false;
    end
    
    % Identical check
    if ~isempty(results.(datasetA).missingFiles) || ~isempty(results.(datasetB).missingFiles)
        identical = false;
    end
    
    % Report
    fprintf(strcat(repmat('=',100,1)','\n'));
    fprintf('Dataset:\t\t%s\n',datasetA)
    printList(results.(datasetA).missingFolders)
    printList(results.(datasetA).missingFiles)
    
    fprintf(strcat(repmat('=',100,1)','\n'));
    fprintf('Dataset:\t\t%s\n',datasetB)
    printList(results.(datasetB).missingFolders)
    printList(results.(datasetB).missingFiles)
    
    % End of report
    fprintf(strcat(repmat('=',100,1)','\n'));
    

end

% Modify file list functions
function fileList = modifyFileList(fileList,root)
    % Iterate over file list: change folder names
    for it=1:numel(fileList)
        fileList(it).folder = strrep(fileList(it).folder,root,'');
    end
    % Iterate over file list: change file names
    for it=1:numel(fileList)
        % Check that the current element is not a folder
        if ~strcmp(fileList(it).name,'.') && ~strcmp(fileList(it).name,'..')
            fileList(it).name = fullfile(fileList(it).folder,fileList(it).name);
        end
    end
end

% Print list functions
function printList(currentList)
    % Iterate over list
    if ~isempty(currentList)
        for it=1:length(currentList)
            fprintf('Missing:\t\t%s\n',currentList(it))
        end
    end
end


