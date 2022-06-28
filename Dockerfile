FROM tensorflow/tensorflow:1.14.0-gpu-py3-jupyter

ENV PATH="/root/miniconda3/bin:${PATH}"

RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub 
RUN apt-get update && apt-get install -y wget git && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh


WORKDIR /tf

COPY . .

RUN conda env create -f environment.yml

SHELL ["conda", "run", "-n", "rl_book", "/bin/bash", "-c"]

#RUN conda activate rl-book && pip install -r requirements.txt


ENTRYPOINT [ "conda", "run", "--no-capture-output", "-n", "rl_book", "jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"]
#CMD jupyter notebook --ip=0.0.0.0 --allow-root 
#conda --version
