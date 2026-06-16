-- 1. Criação da tabela e dados de exemplo
CREATE TABLE notas (
  aluno_id INT,
  nota DECIMAL(4,2)
);

INSERT INTO notas VALUES
(1, 8.5),
(1, 7.0),
(1, 7.75);

-- 2. Criação do procedimento armazenado
DELIMITER $$

CREATE PROCEDURE MediaNotasAluno(IN p_aluno_id INT)
BEGIN
  DECLARE v_existe INT;
  DECLARE media DECIMAL(4,2);

  -- Verifica se o aluno existe
  SELECT COUNT(*) INTO v_existe FROM notas WHERE aluno_id = p_aluno_id;

  IF v_existe = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Aluno não existe.';
  ELSE
    -- Calcula a média das notas do aluno específico
    SELECT AVG(nota) INTO media FROM notas WHERE aluno_id = p_aluno_id;
    
    -- Retorna o resultado
    SELECT media AS media_final;
  END IF;
END $$

DELIMITER ;

-- 3. Execução da procedure para teste
CALL MediaNotasAluno(1);
