import glob from "fast-glob";
import { basename, dirname } from "node:path";
import { exec as execAsync } from "node:child_process";
import { mkdir, writeFile } from "node:fs/promises";
import { promisify } from "util";

const exec = promisify(execAsync);

/**
 * Generate the contract json ABI.
 * @param contract The contract path.
 */
async function abi(contract: string): Promise<void> {
  const name = basename(contract).replace(/\.sol$/, "");
  const output = contract.replace(/^src/, "abi").replace(/\.sol$/, ".json");
  await mkdir(dirname(output), { recursive: true });

  const { stdout } = await exec(`forge inspect ${contract}:${name} abi`);
  await writeFile(output, stdout);
}

/**
 * Generate the contract bytecode.
 * @param contract The contract path.
 */
async function bytecode(contract: string): Promise<void> {
  const name = basename(contract).replace(/\.sol$/, "");
  const output = contract.replace(/^src/, "bytecode").replace(/\.sol$/, ".bin");
  await mkdir(dirname(output), { recursive: true });

  const { stdout } = await exec(`forge inspect ${contract}:${name} bytecode`);
  await writeFile(output, stdout);
}

// Get all contracts
let contracts = await glob("src/**/*.sol");
// Filter out types directory
contracts = contracts.filter((contract) => !contract.includes("/types/"));
// Filter out interfaces
contracts = contracts.filter((contract) => !contract.includes("/I"));

const jobs = contracts.reduce<Promise<void>[]>((acc, contract) => {
  console.log(contract);
  acc.push(abi(contract), bytecode(contract));
  return acc;
}, []);

await Promise.all(jobs);
