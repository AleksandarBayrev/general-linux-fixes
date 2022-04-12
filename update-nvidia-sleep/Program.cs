using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

const string fileName = "/usr/bin/nvidia-sleep.sh";

string GetMessage(bool isReverting, string fileName)
{
    return isReverting ? $"Reverting patch of file {fileName}..." : $"Patching file {fileName}...";
}

IList<string> GetFileContent(bool isReverting, IList<string> updatedFileContent)
{
    if (isReverting)
    {
        var index = updatedFileContent.IndexOf("exit 0");
        if (index != -1)
        {
            updatedFileContent.RemoveAt(index);
            updatedFileContent.Insert(index, "");
        }
    }
    return updatedFileContent;
}

Task PatchFile(int exitZeroIndex, bool isReverting, IList<string> fileContent)
{
    return Task.Run(async () =>
    {
        if (isReverting)
        {
            if (exitZeroIndex != 1)
            {
                Console.WriteLine($"No changes made to {fileName}.");
                return;
            }
            fileContent.RemoveAt(exitZeroIndex);
            Console.WriteLine(GetMessage(isReverting, fileName));
            await File.WriteAllTextAsync(fileName, String.Join('\n', fileContent));
        }
        else
        {
            if (exitZeroIndex == 1)
            {
                Console.WriteLine($"No changes made to {fileName}.");
                return;
            }
            fileContent.Insert(1, "exit 0");
            Console.WriteLine(GetMessage(isReverting, fileName));
            await File.WriteAllTextAsync(fileName, String.Join('\n', fileContent));
        }
    });
}

Task CopyAsync(string origin, string target)
{
    return Task.Run(() => File.Copy(origin, target));
}

async Task<IList<string>> ReadFileContents(string fileName)
{
    var fileContents = await File.ReadAllTextAsync(fileName);
    return fileContents.Split("\n").ToList();
}

try
{
    if (!OperatingSystem.IsLinux())
    {
        throw new SystemException("Invalid operating system! Patch is supported only on Linux.");
    }
    var fileContent = await ReadFileContents(fileName);
    if (!File.Exists(fileName))
    {
        await CopyAsync(fileName, $"{fileName}.bak");
    }
    var isReverting = args.Contains("--revert");
    var exitZeroIndex = fileContent.IndexOf("exit 0");

    await PatchFile(exitZeroIndex, isReverting, fileContent);

}
catch (Exception ex)
{
    Console.WriteLine($"Failed patching {fileName}, reason: {ex.Message}");
}