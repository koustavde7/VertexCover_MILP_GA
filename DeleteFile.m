function DeleteFile(filename)
if exist(filename, 'file') == 2
    delete(filename);
end